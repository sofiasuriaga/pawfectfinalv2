import '/backend/supabase/supabase.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
// import '../../flutter_flow/flutter_flow_widgets.dart'; // Not used directly in this file
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'feed_chart_page_model.dart';
export 'feed_chart_page_model.dart';
import 'package:paw_fect_care/utils/feed_chart_filter_utils.dart';
import 'package:collection/collection.dart';

class FeedChartPageWidget extends StatefulWidget {
  const FeedChartPageWidget({super.key});

  static String routeName = 'FeedChartPage';
  static String routePath = '/feedChartPage';

  @override
  State<FeedChartPageWidget> createState() => _FeedChartPageWidgetState();
}

class _FeedChartPageWidgetState extends State<FeedChartPageWidget> {
  late FeedChartPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeedChartPageModel());

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
    _model.filteredDogs = FeedChartFilterUtils.filterDogs(
      allDogs: _model.allDogs,
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
        body: Stack(
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
            Padding( // ADDED/RESTORED THIS OUTER PADDING FOR BOTTOM NAV
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0), // Adjust 100.0 to your nav bar height + desired gap
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                0.0, 25.0, 15.0, 0.0),
                            child: Icon(
                              Icons.notifications_sharp,
                              color: FlutterFlowTheme.of(context).warning,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 1.0)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0), // Removed bottom padding from here
                      child: FutureBuilder<List<FeedChartsRow>>(
                        future: FeedChartsTable().queryRows(
                          queryFn: (q) => q,
                        ),
                        builder: (context, feedChartsSnapshot) {
                          if (!feedChartsSnapshot.hasData) {
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
                          _model.allFeedCharts = feedChartsSnapshot.data!;

                          return Container(
                            width: 355.0,
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
                                    gradient: LinearGradient(colors: [Color(0xFFFD8205), Colors.white], stops: [0.0, 1.0], begin: AlignmentDirectional(0.0, -1.0), end: AlignmentDirectional(0, 1.0),),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.bar_chart_rounded, color: FlutterFlowTheme.of(context).success, size: 30.0,),
                                      Text('Feed Chart', style: FlutterFlowTheme.of(context).titleMedium.override(fontFamily: GoogleFonts.interTight().fontFamily, color: FlutterFlowTheme.of(context).success, fontSize: 22.0, letterSpacing: 0.0,),),
                                      Icon(Icons.bar_chart_rounded, color: FlutterFlowTheme.of(context).success, size: 30.0,),
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 5.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 4.0, color: Color(0x33000000), offset: Offset(0.0,2.0,),)], borderRadius: BorderRadius.circular(16.0),),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                      child: TextFormField(
                                        controller: _model.searchController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Search dogs...',
                                          hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w500,).fontFamily, color: Colors.grey[600], letterSpacing: 0.0,),
                                          enabledBorder: InputBorder.none, focusedBorder: InputBorder.none, errorBorder: InputBorder.none, focusedErrorBorder: InputBorder.none,
                                          filled: true, fillColor: Colors.white,
                                          contentPadding: EdgeInsetsDirectional.fromSTEB(15.0, 12.0, 15.0, 12.0),
                                          suffixIcon: Icon(Icons.search_outlined, color: FlutterFlowTheme.of(context).success, size: 22.0,),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter().fontFamily,color: Colors.black,letterSpacing: 0.0,),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: FutureBuilder<List<DogsRow>>(
                                    future: DogsTable().queryRows(queryFn: (q) => q.order('dog_name', ascending: true),),
                                    builder: (context, dogsSnapshot) {
                                      if (!dogsSnapshot.hasData) {
                                        return Center(child: SizedBox(width: 50.0, height: 50.0, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary,),),),);
                                      }
                                      bool listDataHasChanged = !const DeepCollectionEquality().equals(_model.allDogs, dogsSnapshot.data!);
                                      if(listDataHasChanged){
                                        _model.allDogs = dogsSnapshot.data!;
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          if(mounted) _performFiltering();
                                        });
                                      } else if (_model.filteredDogs.isEmpty && _model.searchQuery.isEmpty && _model.allDogs.isNotEmpty && _model.allDogs.length != _model.filteredDogs.length) {
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          if(mounted) _performFiltering();
                                        });
                                      }

                                      final dogsToDisplay = _model.searchQuery.isEmpty ? _model.allDogs : _model.filteredDogs;

                                      if (dogsToDisplay.isEmpty && _model.searchQuery.isNotEmpty) {
                                        return Padding(padding: const EdgeInsets.symmetric(vertical: 20.0), child: Text('No dogs found for "${_model.searchQuery}".', style: FlutterFlowTheme.of(context).bodyMedium, textAlign: TextAlign.center,));
                                      }
                                      if (dogsToDisplay.isEmpty && _model.allDogs.isEmpty) {
                                        return Padding(padding: const EdgeInsets.symmetric(vertical: 20.0), child: Text('No dogs available.', style: FlutterFlowTheme.of(context).bodyMedium, textAlign: TextAlign.center,));
                                      }

                                      return ListView.builder(
                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                        itemCount: dogsToDisplay.length,
                                        itemBuilder: (context, listViewIndex) {
                                          final listViewDogsRow = dogsToDisplay[listViewIndex];
                                          return Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 20.0, 5.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent, focusColor: Colors.transparent, hoverColor: Colors.transparent, highlightColor: Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  ExpandDogFoodWidget.routeName,
                                                  queryParameters: {
                                                    'dog': serializeParam(listViewDogsRow, ParamType.SupabaseRow,),
                                                    'recipe': serializeParam(_model.allFeedCharts, ParamType.SupabaseRow, isList: true,),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Color(0x33000000), offset: Offset(0.0,1.0,),)], borderRadius: BorderRadius.circular(16.0),),
                                                child: Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 80.0, height: 80.0,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(shape: BoxShape.circle,),
                                                        child: Image.network(
                                                          listViewDogsRow.dogImageUrl != null && listViewDogsRow.dogImageUrl != '' ? listViewDogsRow.dogImageUrl! : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/paw-fect-care-f0aaw3/assets/x0on0kdf9y35/default_dog_image.png',
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/default_dog_image.png'),
                                                        ),
                                                      ),
                                                      SizedBox(width: 12),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(listViewDogsRow.dogName, style: FlutterFlowTheme.of(context).titleSmall.override(fontFamily: GoogleFonts.interTight().fontFamily, color: FlutterFlowTheme.of(context).primary, letterSpacing: 0.0,),),
                                                            Text(valueOrDefault<String>(listViewDogsRow.dogGender,'-'), style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter().fontFamily, color: FlutterFlowTheme.of(context).success, letterSpacing: 0.0,),),
                                                            Text(valueOrDefault<String>(listViewDogsRow.dogBirthday,'-'), style: FlutterFlowTheme.of(context).bodySmall.override(fontFamily: GoogleFonts.interTight().fontFamily,color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,),),
                                                            Text(valueOrDefault<String>(listViewDogsRow.dogAge,'-'), style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter().fontFamily, letterSpacing: 0.0,),),
                                                          ].divide(SizedBox(height: 4)),
                                                        ),
                                                      ),
                                                      Icon(Icons.chevron_right_rounded, color: FlutterFlowTheme.of(context).secondaryText, size: 24.0),
                                                    ],
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
                              ],
                            ),
                          );
                        },
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
    );
  }
}