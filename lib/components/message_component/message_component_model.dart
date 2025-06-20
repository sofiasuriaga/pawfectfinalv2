import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'message_component_widget.dart' show MessageComponentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MessageComponentModel extends FlutterFlowModel<MessageComponentWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  String? _emailAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Send message is required';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (getUsers)] action in Icon widget.
  ApiCallResponse? getUserssssssResult;
  // Stores action output result for [Backend Call - API (PostPushNotif)] action in Icon widget.
  ApiCallResponse? apiResultqo1;

  @override
  void initState(BuildContext context) {
    emailAddressTextControllerValidator = _emailAddressTextControllerValidator;
  }

  @override
  void dispose() {
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();
  }
}
