import '/backend/supabase/supabase.dart';
import '/components/message_component/message_component_widget.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'conversation_page_widget.dart' show ConversationPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConversationPageModel extends FlutterFlowModel<ConversationPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for messageComponent component.
  late MessageComponentModel messageComponentModel;

  @override
  void initState(BuildContext context) {
    messageComponentModel = createModel(context, () => MessageComponentModel());
  }

  @override
  void dispose() {
    messageComponentModel.dispose();
  }
}
