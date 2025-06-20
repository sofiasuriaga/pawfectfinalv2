import '/backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'forgot_password_page_widget.dart' show ForgotPasswordPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPageModel
    extends FlutterFlowModel<ForgotPasswordPageWidget> {
  ///  Local state fields for this page.

  bool sent = false;

  bool codeIsInvalid = false;

  String code = 'A7X9-KD3P-4ZQW';

  ///  State fields for stateful widgets in this page.

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for codefIELD widget.
  FocusNode? codefIELDFocusNode;
  TextEditingController? codefIELDTextController;
  String? Function(BuildContext, String?)? codefIELDTextControllerValidator;
  // Stores action output result for [Backend Call - API (Forgot Password)] action in Button-Login widget.
  ApiCallResponse? apiResultk2q;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    codefIELDFocusNode?.dispose();
    codefIELDTextController?.dispose();
  }
}
