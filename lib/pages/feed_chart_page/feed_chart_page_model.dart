import '/backend/supabase/supabase.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import '../../flutter_flow/flutter_flow_model.dart';
import 'feed_chart_page_widget.dart' show FeedChartPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FeedChartPageModel extends FlutterFlowModel<FeedChartPageWidget> {
  ///  State fields for stateful widgets in this page.

  late BottomNavigationBarModel bottomNavigationBarModel;

  TextEditingController? searchController;
  String searchQuery = '';
  List<DogsRow> allDogs = [];
  List<DogsRow> filteredDogs = [];
  List<FeedChartsRow> allFeedCharts = [];

  @override
  void initState(BuildContext context) {
    bottomNavigationBarModel =
        createModel(context, () => BottomNavigationBarModel());
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    bottomNavigationBarModel.dispose();
    searchController?.dispose();
  }
}