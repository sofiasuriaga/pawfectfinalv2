import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/add_task_component/add_task_component_widget.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '/components/delete_task_widget.dart';
import '/components/follow_up_task_component/follow_up_task_component_widget.dart';
import '/components/pop_up_task_component/pop_up_task_component_widget.dart';
import '/components/success_component/success_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import '/flutter_flow/flutter_flow_model.dart';
import 'dashboard_assigned_task_page_widget.dart' show DashboardAssignedTaskPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardAssignedTaskPageModel extends FlutterFlowModel<DashboardAssignedTaskPageWidget> {
  ApiCallResponse? apiResult464;
  ApiCallResponse? getUsersResponse;
  ApiCallResponse? getDogsRespons;
  ApiCallResponse? apiResulttcc;
  ApiCallResponse? apiResultis9;
  TabController? tabBarController;
  ApiCallResponse? apiResult62osdasda;
  BottomNavigationBarModel bottomNavigationBarModel;

  String searchQuery = '';
  TextEditingController? searchController;
  List<TasksWithDogStruct> allTasks = [];
  List<TasksWithDogStruct> filteredActiveTasks = [];
  List<TasksWithDogStruct> filteredCompletedTasks = [];
  bool isLoadingTasks = true;

  DashboardAssignedTaskPageModel() : bottomNavigationBarModel = BottomNavigationBarModel();

  @override
  void initState(BuildContext context) {
    bottomNavigationBarModel = createModel(context, () => BottomNavigationBarModel());
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    bottomNavigationBarModel.dispose();
    searchController?.dispose();
  }
}