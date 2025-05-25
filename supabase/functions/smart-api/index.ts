import { serve } from "https://deno.land/std@0.203.0/http/server.ts";
import { create } from "https://deno.land/x/djwt@v2.8/mod.ts";
const GOOGLE_OAUTH_TOKEN_URL = "https://oauth2.googleapis.com/token";
const FIREBASE_PROJECT_ID = "pawfectcare-8d21c"; // <-- your Firebase project ID
const SCOPES = [
  "https://www.googleapis.com/auth/firebase.messaging"
];
// Convert PEM private key string to Uint8Array
function pemToUint8Array(pem) {
  const b64 = pem.replace("-----BEGIN PRIVATE KEY-----", "").replace("-----END PRIVATE KEY-----", "").replace(/\n/g, "");
  const binaryString = atob(b64);
  const len = binaryString.length;
  const bytes = new Uint8Array(len);
  for(let i = 0; i < len; i++){
    bytes[i] = binaryString.charCodeAt(i);
  }
  return bytes.buffer;
}
// Create JWT
async function createJwtAssertion(serviceAccount) {
  const now = Math.floor(Date.now() / 1000);
  const payload = {
    iss: serviceAccount.client_email,
    scope: SCOPES.join(" "),
    aud: GOOGLE_OAUTH_TOKEN_URL,
    iat: now,
    exp: now + 3600
  };
  const key = await crypto.subtle.importKey("pkcs8", pemToUint8Array(serviceAccount.private_key), {
    name: "RSASSA-PKCS1-v1_5",
    hash: "SHA-256"
  }, false, [
    "sign"
  ]);
  const jwt = await create({
    alg: "RS256",
    typ: "JWT"
  }, payload, key);
  return jwt;
}
// Exchange JWT for access token
async function exchangeJwtForAccessToken(jwt) {
  const response = await fetch(GOOGLE_OAUTH_TOKEN_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt
    }).toString()
  });
  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(`Token exchange failed: ${response.status} - ${errorText}`);
  }
  const json = await response.json();
  return json.access_token;
}
// Insert notification into Supabase
async function insertIntoSupabase(notification) {
  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const supabaseKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!supabaseUrl || !supabaseKey) {
    throw new Error("Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY env var");
  }
  const response = await fetch(`${supabaseUrl}/rest/v1/notifications`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "apikey": supabaseKey,
      "Authorization": `Bearer ${supabaseKey}`,
      "Prefer": "return=representation"
    },
    body: JSON.stringify(notification)
  });
  const result = await response.json();
  if (!response.ok) {
    throw new Error(`Supabase insert error: ${JSON.stringify(result)}`);
  }
  return result;
}
// Main handler
serve(async (req)=>{
  try {
    if (req.method !== "POST") {
      return new Response("Method not allowed", {
        status: 405
      });
    }
    const serviceAccountStr = Deno.env.get("FIREBASE_SERVICE_ACCOUNT");
    if (!serviceAccountStr) {
      return new Response("FIREBASE_SERVICE_ACCOUNT env var not set", {
        status: 500
      });
    }
    const serviceAccount = JSON.parse(serviceAccountStr);
    const { token, title, body } = await req.json();
    if (!token || !title || !body) {
      return new Response("Missing token/title/body", {
        status: 400
      });
    }
    const jwtAssertion = await createJwtAssertion(serviceAccount);
    const accessToken = await exchangeJwtForAccessToken(jwtAssertion);
    const fcmUrl = `https://fcm.googleapis.com/v1/projects/${FIREBASE_PROJECT_ID}/messages:send`;
    const messagePayload = {
      message: {
        token,
        notification: {
          title,
          body
        }
      }
    };
    const fcmResponse = await fetch(fcmUrl, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${accessToken}`,
        "Content-Type": "application/json"
      },
      body: JSON.stringify(messagePayload)
    });
    const fcmResult = await fcmResponse.json();
    if (!fcmResponse.ok) {
      return new Response(JSON.stringify({
        error: "FCM error",
        details: fcmResult
      }), {
        status: 500,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    // Insert into Supabase
    const notificationData = {
      token,
      title,
      body,
      sent_at: new Date().toISOString()
    };
    const inserted = await insertIntoSupabase(notificationData);
    return new Response(JSON.stringify({
      success: true,
      fcm: fcmResult,
      inserted
    }), {
      status: 200,
      headers: {
        "Content-Type": "application/json"
      }
    });
  } catch (error) {
    return new Response(JSON.stringify({
      error: error.message
    }), {
      status: 500,
      headers: {
        "Content-Type": "application/json"
      }
    });
  }
});
