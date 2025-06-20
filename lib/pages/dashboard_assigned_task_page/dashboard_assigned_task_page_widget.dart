import 'package:paw_fect_care/utils/task_filter_utils.dart';

import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/add_task_component/add_task_component_widget.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '/components/delete_task_widget.dart';
import '/components/follow_up_task_component/follow_up_task_component_widget.dart';
import '/components/pop_up_task_component/pop_up_task_component_widget.dart';
import '/components/success_component/success_component_widget.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dashboard_assigned_task_page_model.dart';
export 'dashboard_assigned_task_page_model.dart';

class DashboardAssignedTaskPageWidget extends StatefulWidget {
  const DashboardAssignedTaskPageWidget({super.key});

  static String routeName = 'DashboardAssignedTaskPage';
  static String routePath = '/dashboardAssignedTaskPage';

  @override
  State<DashboardAssignedTaskPageWidget> createState() =>
      _DashboardAssignedTaskPageWidgetState();
}

class _DashboardAssignedTaskPageWidgetState
    extends State<DashboardAssignedTaskPageWidget>
    with TickerProviderStateMixin {
  late DashboardAssignedTaskPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardAssignedTaskPageModel());

    _model.searchController ??= TextEditingController();
    _model.searchController!.addListener(_onSearchChanged);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      safeSetState(() {
        _model.isLoadingTasks = true;
      });

      final tasksResponse = await GetTasksWithDogsCall.call(
        accessToken: FFAppState().accessToken,
      );

      await Future.wait([
        Future(() async {
          _model.getUsersResponse = await GetUsersCall.call(
            accessToken: FFAppState().accessToken,
          );
        }),
        Future(() async {
          _model.getDogsRespons = await GetDogsCall.call(
            accessToken: FFAppState().accessToken,
          );
        }),
      ]);

      if (tasksResponse.succeeded && tasksResponse.jsonBody != null) {
        _model.allTasks = (tasksResponse.jsonBody.toList()
            .map<TasksWithDogStruct?>((e) => TasksWithDogStruct.maybeFromMap(e))
            .toList() as Iterable<TasksWithDogStruct?>)
            .whereType<TasksWithDogStruct>()
            .toList();
      } else {
        _model.allTasks = [];
        print('Failed to load tasks. Status: ${tasksResponse.statusCode}, Response: ${tasksResponse.jsonBody}');
      }

      _performFiltering();

      safeSetState(() {
        _model.isLoadingTasks = false;
      });
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() {
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _onSearchChanged() {
    if (_model.searchQuery != _model.searchController!.text) {
      _model.searchQuery = _model.searchController!.text;
      _performFiltering();
    }
  }

  void _performFiltering() {
    safeSetState(() {
      _model.filteredActiveTasks = TaskFilterUtils.filterAndSortTasks(
        allTasks: _model.allTasks,
        statusFilter: 'Active',
        searchQuery: _model.searchQuery,
        sortByDateCreatedDescending: true,
      );
      _model.filteredCompletedTasks = TaskFilterUtils.filterAndSortTasks(
        allTasks: _model.allTasks,
        statusFilter: 'Completed',
        searchQuery: _model.searchQuery,
        sortByDateCompletedDescending: true,
      );
    });
  }

  @override
  void dispose() {
    _model.searchController?.removeListener(_onSearchChanged);
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/blue.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/logo_transparent.png',
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          200.0, 25.0, 0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                              NotificationPageWidget.routeName);
                                        },
                                        child: Icon(
                                          Icons.notifications_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .warning,
                                          size: 30.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 25.0, 15.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await Future.wait([
                                            Future(() async {
                                              _model.apiResulttcc =
                                              await LogoutCall.call(
                                                accessToken:
                                                FFAppState().accessToken,
                                              );
                                            }),
                                            Future(() async {
                                              _model.apiResultis9 =
                                              await PatchFCMTokenCall.call(
                                                id: FFAppState().userid,
                                                accessToken:
                                                FFAppState().accessToken,
                                                fcmToken: '',
                                              );
                                            }),
                                          ]);

                                          context.pushNamed(
                                              LoginPageWidget.routeName);

                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.login,
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          size: 30.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 1.0)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tasks Assigned',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                      fontFamily: GoogleFonts.interTight(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontWeight,
                                      ).fontFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  if (FFAppState().usertype == 'Owner')
                                    Builder(
                                      builder: (context) => Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 15.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  alignment:
                                                  AlignmentDirectional(
                                                      0.0, 0.0)
                                                      .resolve(
                                                      Directionality.of(
                                                          context)),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(
                                                          dialogContext)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Container(
                                                      height: 500.0,
                                                      width: 355.0,
                                                      child:
                                                      AddTaskComponentWidget(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((_) => _refreshData());
                                          },
                                          text: 'New Task',
                                          icon: Icon(
                                            Icons.add_outlined,
                                            size: 20.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 35.0,
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16.0, 0.0, 16.0, 0.0),
                                            iconAlignment: IconAlignment.start,
                                            iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFFD8205),
                                            textStyle: FlutterFlowTheme.of(
                                                context)
                                                .titleSmall
                                                .override(
                                              fontFamily: GoogleFonts.interTight(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .titleSmall
                                                    .fontWeight,
                                              ).fontFamily,
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                            elevation: 0.0,
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 10.0, 15.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.searchController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Search tasks...',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                        ).fontFamily,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).primary,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).error,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).error,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsetsDirectional.fromSTEB(10.0, 12.0, 10.0, 12.0),
                                      suffixIcon: Icon(
                                        Icons.search_outlined,
                                        color: FlutterFlowTheme.of(context).success,
                                        size: 22.0,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: GoogleFonts.inter().fontFamily,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 110.0),
                              child: Container(
                                width: 355.0,
                                height: 456.09,
                                constraints: BoxConstraints(
                                  maxHeight: 504.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, 0),
                                      child: TabBar(
                                        labelColor: Colors.black,
                                        unselectedLabelColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                          fontFamily: GoogleFonts.interTight(
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .fontWeight,
                                          ).fontFamily,
                                          letterSpacing: 0.0,
                                        ),
                                        unselectedLabelStyle: FlutterFlowTheme
                                            .of(context)
                                            .titleMedium
                                            .override(
                                          fontFamily: GoogleFonts.interTight(
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .fontWeight,
                                          ).fontFamily,
                                          letterSpacing: 0.0,
                                        ),
                                        indicatorColor: Color(0xFFFD8205),
                                        tabs: [
                                          Tab(
                                            text: 'Current',
                                          ),
                                          Tab(
                                            text: 'Completed',
                                          ),
                                        ],
                                        controller: _model.tabBarController,
                                        onTap: (i) async {
                                          [() async {}, () async {}][i]();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _model.tabBarController,
                                        children: [
                                          _buildTaskList(_model.filteredActiveTasks, 'Active'),
                                          _buildTaskList(_model.filteredCompletedTasks, 'Completed'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: wrapWithModel(
                          model: _model.bottomNavigationBarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: BottomNavigationBarWidget(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList(List<TasksWithDogStruct> tasks, String status) {
    if (_model.isLoadingTasks) {
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

    if (tasks.isEmpty) {
      return Center(
        child: Text(
          'No ${status.toLowerCase()} tasks found${_model.searchQuery.isNotEmpty ? ' for "${_model.searchQuery}"' : ''}.',
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final taskItem = tasks[index];

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (FFAppState().usertype == 'Owner')
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: Builder(
                    builder: (context) => Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 30.0, 0.0),
                      child: InkWell(
                        onTap: () async {
                          if (status == 'Active') {
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(dialogContext).unfocus();
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                    child: DeleteTaskWidget(
                                      id: taskItem.id,
                                    ),
                                  ),
                                );
                              },
                            ).then((_) => _refreshData());
                          } else {
                            _model.apiResult62osdasda = await DeleteTaskByIDCall.call(
                              id: taskItem.id,
                              accessToken: FFAppState().accessToken,
                            );
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                  child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(dialogContext).unfocus();
                                        FocusManager.instance.primaryFocus?.unfocus();
                                      },
                                      child: SuccessComponentWidget()
                                  ),
                                );
                              },
                            ).then((_) => _refreshData());
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: FlutterFlowTheme.of(context).error,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      20.0, (status == 'Active' && FFAppState().usertype == 'Owner' ? 0.0 : 10.0), 20.0, 0.0),
                  child: InkWell(
                    onTap: () async {
                      if (FFAppState().usertype == 'Caretaker') {
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(dialogContext).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Container(
                                  height: 400.0,
                                  width: 400.0,
                                  child: PopUpTaskComponentWidget(
                                    tasks: taskItem,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).then((_) => _refreshData());
                      } else {
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(dialogContext).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Container(
                                  height: 300.0,
                                  width: 300.0,
                                  child: FollowUpTaskComponentWidget(
                                    tasks: taskItem,
                                    assignedTo: taskItem.assignedTo,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).then((_) => _refreshData());
                      }
                    },
                    child: Container(
                      width: 314.6,
                      constraints: BoxConstraints(minHeight: 180.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(0.0, 2.0,),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Color(0x0014181B),),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  'Tasks: ${valueOrDefault<String>(
                                    taskItem.taskTitle,
                                    '-',
                                  )}',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).labelLarge.override(
                                    fontFamily: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                    ).fontFamily,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  'Description: ${valueOrDefault<String>(
                                    taskItem.taskDescription,
                                    '-',
                                  )}',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).labelLarge.override(
                                    fontFamily: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                    ).fontFamily,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          taskItem.status == 'Completed'
                                              ? valueOrDefault<String>(
                                            taskItem.dateCompleted,
                                            '-',
                                          )
                                              : valueOrDefault<String>(
                                            taskItem.dateCreated,
                                            '-',
                                          ),
                                          '-',
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                          ).fontFamily,
                                          color: FlutterFlowTheme.of(context).success,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF249689),
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context).success,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        taskItem.status,
                                        '-',
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                        ).fontFamily,
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (status == 'Active')
                                Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                    child: RichText(
                                      textScaler: MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Last Follow Up: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: valueOrDefault<String>(
                                              taskItem.lastFollowUpAt,
                                              '-',
                                            ),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w600,
                                              ).fontFamily,
                                              color: Color(0xFFFD8205),
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w500,
                                          ).fontFamily,
                                          color: Color(0xFF101213),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (status == 'Completed')
                                Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                    child: RichText(
                                      textScaler: MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Completed: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: valueOrDefault<String>(
                                              taskItem.dateCompleted,
                                              '-',
                                            ),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w600,
                                              ).fontFamily,
                                              color: Color(0xFFFD8205),
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w500,
                                          ).fontFamily,
                                          color: Color(0xFF101213),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                      child: RichText(
                                        textScaler: MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Assigned from: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                taskItem.assignedByUser.userFullname,
                                                '-',
                                              ),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.w600,
                                                ).fontFamily,
                                                color: Color(0xFFFD8205),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w500,
                                            ).fontFamily,
                                            color: Color(0xFF101213),
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: Color(0xFFFD8205),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                      child: RichText(
                                        textScaler: MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Assigned to: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                taskItem.assignedToUser.userFullname,
                                                '-',
                                              ),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.w600,
                                                ).fontFamily,
                                                color: Color(0xFFFD8205),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w500,
                                            ).fontFamily,
                                            color: Color(0xFF101213),
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ].divide(SizedBox(height: 10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _refreshData() async {
    safeSetState(() {
      _model.isLoadingTasks = true;
    });

    final tasksResponse = await GetTasksWithDogsCall.call(
      accessToken: FFAppState().accessToken,
    );

    if (tasksResponse.succeeded && tasksResponse.jsonBody != null) {
      _model.allTasks = (tasksResponse.jsonBody.toList()
          .map<TasksWithDogStruct?>((e) => TasksWithDogStruct.maybeFromMap(e))
          .toList() as Iterable<TasksWithDogStruct?>)
          .whereType<TasksWithDogStruct>()
          .toList();
    } else {
      _model.allTasks = [];
      print('Failed to refresh tasks. Status: ${tasksResponse.statusCode}, Response: ${tasksResponse.jsonBody}');
    }

    _performFiltering();

    safeSetState(() {
      _model.isLoadingTasks = false;
    });
  }
}