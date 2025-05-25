import 'package:paw_fect_care/utils/team_filter_utils.dart';
import 'package:collection/collection.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '/components/conversation_new/conversation_new_widget.dart';
import '/components/dropdown_status_component/dropdown_status_component_widget.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'team_page_model.dart';
export 'team_page_model.dart';

class TeamPageWidget extends StatefulWidget {
  const TeamPageWidget({super.key});

  static String routeName = 'TeamPage';
  static String routePath = '/teamPage';

  @override
  State<TeamPageWidget> createState() => _TeamPageWidgetState();
}

class _TeamPageWidgetState extends State<TeamPageWidget> {
  late TeamPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeamPageModel());

    _model.searchController ??= TextEditingController();
    _model.searchController!.addListener(_onSearchChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _onSearchChanged() {
    if (!mounted) return;
    if (_model.searchQuery != _model.searchController!.text) {
      _model.searchQuery = _model.searchController!.text;
      _performFiltering();
    }
  }

  void _performFiltering() {
    if (!mounted) return;
    _model.filteredMembers = TeamFilterUtils.filterTeamMembers(
      allMembers: _model.allMembers,
      searchQuery: _model.searchQuery,
    );
    safeSetState(() {});
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 110.0),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/logo_transparent.png',
                                            width: 100.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                        AlignmentDirectional(0.0, -1.0),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 25.0, 15.0, 0.0),
                                          child: InkWell(
                                            onTap: () {
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
                                    ].divide(SizedBox(width: 1.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Container(
                                    width: 355.0,
                                    height: MediaQuery.sizeOf(context).height * 0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 355.8,
                                          height: 63.4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient( colors: [Color(0xFFFD8205),Colors.white], stops: [0.0, 1.0], begin: AlignmentDirectional(0.0, -1.0), end: AlignmentDirectional(0, 1.0),),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0),topRight: Radius.circular(16.0),),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.groups_2_sharp,color: FlutterFlowTheme.of(context).success,size: 30.0,),
                                              Text('Team Page', style: FlutterFlowTheme.of(context).titleMedium.override(fontFamily: GoogleFonts.interTight().fontFamily, color: FlutterFlowTheme.of(context).success, fontSize: 22.0, letterSpacing: 0.0,),),
                                              Icon(Icons.groups_2_sharp,color: FlutterFlowTheme.of(context).success,size: 30.0,),
                                            ].divide(SizedBox(width: 10.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 5.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 4.0,color: Color(0x33000000),offset: Offset(0.0,2.0,),)], borderRadius: BorderRadius.circular(16.0),),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                              child: TextFormField(
                                                controller: _model.searchController,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText: 'Search members...',
                                                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w500,).fontFamily,color: Colors.grey[600],letterSpacing: 0.0,),
                                                  enabledBorder: InputBorder.none, focusedBorder: InputBorder.none, errorBorder: InputBorder.none, focusedErrorBorder: InputBorder.none,
                                                  filled: true, fillColor: Colors.white,
                                                  contentPadding: EdgeInsetsDirectional.fromSTEB(15.0, 12.0, 15.0, 12.0),
                                                  suffixIcon: Icon(Icons.search_outlined,color: FlutterFlowTheme.of(context).success,size: 22.0,),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter().fontFamily,color: Colors.black,letterSpacing: 0.0,),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(25.0, 15.0, 0.0, 0.0),
                                            child: Text('Myself',style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w600,).fontFamily,letterSpacing: 0.0,),),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                                          child: Container(
                                            width: double.infinity, height: 54.0,
                                            decoration: BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(blurRadius: 4.0,color: Color(0x33000000),offset: Offset(0.0, 2.0,),)],borderRadius: BorderRadius.circular(16.0),),
                                            child: Align(
                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(18.0, 8.0, 8.0, 8.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(child: Container(decoration: BoxDecoration(), child: Text(FFAppState().userName, style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w500,).fontFamily, color: Colors.black, fontSize: 12.0, letterSpacing: 0.0,),),),),
                                                  ].divide(SizedBox(width: 10.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(25.0, 20.0, 0.0, 10.0),
                                            child: Text('Members',style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w600,).fontFamily,letterSpacing: 0.0,),),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: StreamBuilder<List<UsersRow>>(
                                              stream: _model.listViewSupabaseStream ??= SupaFlow.client.from("users").stream(primaryKey: ['id']).order('user_fullname', ascending: true).map((list) => list.map((item) => UsersRow(item)).toList()),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {return Center(child: SizedBox(width: 50.0, height: 50.0, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary))));}
                                                List<UsersRow> rawUsersList = snapshot.data!;

                                                bool listDataHasChanged = !const DeepCollectionEquality().equals(_model.allMembers, rawUsersList);
                                                if (listDataHasChanged) {
                                                  _model.allMembers = rawUsersList;
                                                  WidgetsBinding.instance.addPostFrameCallback((_) { if (mounted) _performFiltering();});
                                                } else if (_model.filteredMembers.isEmpty && _model.searchQuery.isEmpty && _model.allMembers.isNotEmpty && _model.allMembers.length != _model.filteredMembers.length ) {
                                                  WidgetsBinding.instance.addPostFrameCallback((_) {if (mounted) _performFiltering();});
                                                }
                                                final membersToDisplay = _model.searchQuery.isEmpty ? _model.allMembers : _model.filteredMembers;
                                                if (membersToDisplay.isEmpty && _model.searchQuery.isNotEmpty) {return Padding(padding: const EdgeInsets.symmetric(vertical: 20.0), child: Text('No members found for "${_model.searchQuery}".', style: FlutterFlowTheme.of(context).bodyMedium, textAlign: TextAlign.center));}
                                                if (membersToDisplay.isEmpty && _model.allMembers.isEmpty) {return Padding(padding: const EdgeInsets.symmetric(vertical: 20.0), child: Text('No members yet.', style: FlutterFlowTheme.of(context).bodyMedium, textAlign: TextAlign.center));}

                                                return ListView.builder(
                                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 10.0),
                                                  itemCount: membersToDisplay.length,
                                                  itemBuilder: (context, listViewIndex) {
                                                    final listViewUsersRow = membersToDisplay[listViewIndex];
                                                    return Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                      child: Container(
                                                        width: double.infinity, height: 54.0,
                                                        decoration: BoxDecoration(color: Colors.white, boxShadow: [ BoxShadow(blurRadius: 4.0, color: Color(0x33000000), offset: Offset(0.0,2.0,)) ], borderRadius: BorderRadius.circular(16.0),),
                                                        child: Align(
                                                          alignment: AlignmentDirectional(-1.0,0.0),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(8.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded( flex: 3, child: Padding( padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0), child: Text(valueOrDefault<String>(listViewUsersRow.userFullname,'-'), textAlign: TextAlign.start, style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: GoogleFonts.inter(fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,).fontFamily, fontSize: 12.0, letterSpacing: 0.0),),),),
                                                                Expanded( flex: 1, child: Builder(builder: (context) => InkWell( splashColor: Colors.transparent, focusColor: Colors.transparent, hoverColor: Colors.transparent, highlightColor: Colors.transparent,
                                                                  onTap: () async { _model.apiResult8qn = await GetConversationCall.call(accessToken: FFAppState().accessToken); await showDialog(context: context, builder: (dialogContext) { return Dialog(elevation: 0, insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)), child: GestureDetector(onTap: () { FocusScope.of(dialogContext).unfocus(); FocusManager.instance.primaryFocus?.unfocus(); }, child: ConversationNewWidget(user: listViewUsersRow, apiResult8qn: ConversationStruct.maybeFromMap((_model.apiResult8qn?.jsonBody ?? ''))),),);},); safeSetState(() {});},
                                                                  child: Icon(Icons.message, color: FlutterFlowTheme.of(context).success, size: 24.0),),),),
                                                                if (FFAppState().usertype == 'Admin') Expanded( flex: 2, child: DropdownStatusComponentWidget(key: Key('Keyn8x_${listViewIndex}_of_${membersToDisplay.length}'), users: listViewUsersRow,),),
                                                              ].divide(SizedBox(width: 5.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
}