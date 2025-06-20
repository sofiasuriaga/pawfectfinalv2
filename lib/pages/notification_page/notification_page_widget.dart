import '/backend/supabase/supabase.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
// import '../../flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '../../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notification_page_model.dart';
export 'notification_page_model.dart';

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  static String routeName = 'NotificationPage';
  static String routePath = '/notificationPage';

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget> {
  late NotificationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF14181B),
            ),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            'Notifications',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: GoogleFonts.outfit(
                fontWeight: FontWeight.normal,
              ).fontFamily,
              color: Color(0xFF14181B),
              fontSize: 24.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: StreamBuilder<List<NotificationsRow>>(
          stream: _model.listViewSupabaseStream ??= SupaFlow.client
              .from("notifications")
              .stream(primaryKey: ['id'])
              .eqOrNull(
            'notification_user_ids',
            FFAppState().userid,
          )
              .order('sent_at', ascending: false)
              .map((list) =>
              list.map((item) => NotificationsRow(item)).toList()),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              );
            }
            List<NotificationsRow> listViewNotificationsRowList =
            snapshot.data!;

            if (listViewNotificationsRowList.isEmpty) {
              return Center(
                child: Text(
                  'No notifications yet.',
                  style: FlutterFlowTheme.of(context).labelLarge,
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: listViewNotificationsRowList.length,
              itemBuilder: (context, listViewIndex) {
                final listViewNotificationsRow =
                listViewNotificationsRowList[listViewIndex];
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.0,
                          color: Color(0xFFE0E3E7),
                          offset: Offset(0.0,1.0,),
                        )
                      ],
                      borderRadius: BorderRadius.circular(0.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 4.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).success,
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  listViewNotificationsRow.body,
                                  '-',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                  fontFamily: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.normal,
                                  ).fontFamily,
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              listViewNotificationsRow.sentAt != null
                                  ? valueOrDefault<String>(
                                functions.newCustomFunction(
                                    listViewNotificationsRow.sentAt!),
                                '-',
                              )
                                  : '-',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                fontFamily: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600,
                                ).fontFamily,
                                color: Colors.black,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}