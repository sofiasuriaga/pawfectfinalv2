import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'forgot_password_with_fields_widget.dart'
    show ForgotPasswordWithFieldsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordWithFieldsModel
    extends FlutterFlowModel<ForgotPasswordWithFieldsWidget> {
  ///  Local state fields for this page.

  bool doNotMatch = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for newPass widget.
  FocusNode? newPassFocusNode;
  TextEditingController? newPassTextController;
  String? Function(BuildContext, String?)? newPassTextControllerValidator;
  // State field(s) for confirmPass widget.
  FocusNode? confirmPassFocusNode;
  TextEditingController? confirmPassTextController;
  String? Function(BuildContext, String?)? confirmPassTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    newPassFocusNode?.dispose();
    newPassTextController?.dispose();

    confirmPassFocusNode?.dispose();
    confirmPassTextController?.dispose();
  }
}
