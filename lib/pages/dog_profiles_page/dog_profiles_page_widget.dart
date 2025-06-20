import 'package:paw_fect_care/utils/dog_profiles_filter_utils.dart';
import 'package:collection/collection.dart';

import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/add_new_doggo_component/add_new_doggo_component_widget.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '/components/delete_dog_component_widget.dart';
import '/components/view_doggo_profile_component/view_doggo_profile_component_widget.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '../../flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dog_profiles_page_model.dart';
export 'dog_profiles_page_model.dart';

class DogProfilesPageWidget extends StatefulWidget {
  const DogProfilesPageWidget({super.key});

  static String routeName = 'DogProfilesPage';
  static String routePath = '/dogProfilesPage';

  @override
  State<DogProfilesPageWidget> createState() => _DogProfilesPageWidgetState();
}

class _DogProfilesPageWidgetState extends State<DogProfilesPageWidget> {
  late DogProfilesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DogProfilesPageModel());

    _model.searchDoggosTextController ??= TextEditingController();
    _model.searchDoggosFocusNode ??= FocusNode();
    _model.searchDoggosTextController!.addListener(_onSearchChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _onSearchChanged() {
    if (!mounted) return;
    if (_model.searchQuery != _model.searchDoggosTextController!.text) {
      _model.searchQuery = _model.searchDoggosTextController!.text;
      _performFiltering();
    }
  }

  void _performFiltering() {
    if (!mounted) return;
    _model.filteredDoggos = DogProfilesFilterUtils.filterDoggos(
      allDoggos: _model.allDoggos,
      searchQuery: _model.searchQuery,
    );
    safeSetState(() {});
  }

  @override
  void dispose() {
    _model.searchDoggosTextController?.removeListener(_onSearchChanged);
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
        body: Container(
          decoration: BoxDecoration(),
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
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
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
                                color: FlutterFlowTheme.of(context).warning,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 1.0)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Container(
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
                            if (FFAppState().usertype == 'Owner')
                              Align(
                                alignment: AlignmentDirectional(1.0, -1.0),
                                child: Builder(
                                  builder: (context) => Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 15.0, 5.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor: Colors.transparent,
                                              alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                              child: GestureDetector(
                                                onTap: () { FocusScope.of(dialogContext).unfocus(); FocusManager.instance.primaryFocus?.unfocus(); },
                                                child: AddNewDoggoComponentWidget(),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.add_box,
                                        color: Color(0xFFFD8205),
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(15.0, (FFAppState().usertype == 'Owner' ? 5.0 : 15.0) , 15.0, 10.0),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.searchDoggosTextController,
                                  focusNode: _model.searchDoggosFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Search doggos...',
                                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate,width: 2.0,), borderRadius: BorderRadius.circular(12.0),),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary,width: 2.0,), borderRadius: BorderRadius.circular(12.0),),
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).error,width: 2.0,), borderRadius: BorderRadius.circular(12.0),),
                                    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).error,width: 2.0,), borderRadius: BorderRadius.circular(12.0),),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                                    prefixIcon: Icon(Icons.search_rounded, color: FlutterFlowTheme.of(context).secondaryText),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                  validator: _model.searchDoggosTextControllerValidator.asValidator(context),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FutureBuilder<List<DogsRow>>(
                                future: DogsTable().queryRows(
                                  queryFn: (q) => q.order('dog_name', ascending: true),
                                ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(child: SizedBox(width: 50.0, height: 50.0, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary,),),),);
                                  }
                                  List<DogsRow> rawDogsList = snapshot.data!;

                                  bool listDataHasChanged = !const DeepCollectionEquality().equals(_model.allDoggos, rawDogsList);
                                  if (listDataHasChanged) {
                                    _model.allDoggos = rawDogsList;
                                    WidgetsBinding.instance.addPostFrameCallback((_) { if(mounted) _performFiltering(); });
                                  } else if (_model.filteredDoggos.isEmpty && _model.searchQuery.isEmpty && _model.allDoggos.isNotEmpty && _model.allDoggos.length != _model.filteredDoggos.length) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) { if(mounted) _performFiltering(); });
                                  }

                                  final doggosToDisplay = _model.searchQuery.isEmpty ? _model.allDoggos : _model.filteredDoggos;

                                  if (doggosToDisplay.isEmpty && _model.searchQuery.isNotEmpty) {
                                    return Padding(padding: const EdgeInsets.all(16.0), child: Text('No doggos found for "${_model.searchQuery}".', style: FlutterFlowTheme.of(context).bodyMedium, textAlign: TextAlign.center,));
                                  }
                                  if (doggosToDisplay.isEmpty && _model.allDoggos.isEmpty) {
                                    return Padding(padding: const EdgeInsets.all(16.0), child: Text('No doggos added yet.', style: FlutterFlowTheme.of(context).bodyMedium, textAlign: TextAlign.center,));
                                  }

                                  return ListView.builder(
                                    padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 10.0),
                                    itemCount: doggosToDisplay.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewDogsRow = doggosToDisplay[listViewIndex];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (FFAppState().usertype == 'Owner')
                                              Align(
                                                alignment: AlignmentDirectional(1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                                  child: InkWell(
                                                    onTap: () async { await showDialog(context: context, builder: (dialogContext) { return Dialog(elevation: 0, insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)), child: GestureDetector(onTap: () { FocusScope.of(dialogContext).unfocus(); FocusManager.instance.primaryFocus?.unfocus(); }, child: DeleteDogComponentWidget(id: listViewDogsRow.id,),),);},);},
                                                    child: Icon(Icons.delete_sharp, color: FlutterFlowTheme.of(context).error, size: 22.0,),
                                                  ),
                                                ),
                                              ),
                                            InkWell(
                                              onTap: () async { await showDialog(context: context, builder: (dialogContext) { return Dialog(elevation: 0, insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)), child: GestureDetector(onTap: () { FocusScope.of(dialogContext).unfocus(); FocusManager.instance.primaryFocus?.unfocus(); }, child: ViewDoggoProfileComponentWidget(dog: listViewDogsRow,),),);},);},
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 4.0, color: Color(0x33000000), offset: Offset(0.0,2.0,),)], borderRadius: BorderRadius.circular(12.0),),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 70.0, height: 70.0,
                                                        clipBehavior: Clip.antiAlias, decoration: BoxDecoration(shape: BoxShape.circle,),
                                                        child: Image.network(
                                                          listViewDogsRow.dogImageUrl != null && listViewDogsRow.dogImageUrl!.isNotEmpty ? listViewDogsRow.dogImageUrl! : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/paw-fect-care-f0aaw3/assets/x0on0kdf9y35/default_dog_image.png',
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
                                                            Text(valueOrDefault<String>(listViewDogsRow.dogName,'Unknown Dog',), style: FlutterFlowTheme.of(context).titleSmall.override(fontFamily: GoogleFonts.interTight().fontFamily, color: Colors.black, letterSpacing: 0.0,),),
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Text(valueOrDefault<String>(listViewDogsRow.dogGender, 'N/A',), style: FlutterFlowTheme.of(context).bodySmall.override(fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w500,).fontFamily,fontSize: 12.0, letterSpacing: 0.0, color: FlutterFlowTheme.of(context).secondaryText),),
                                                                Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0), child: Text('•', style: FlutterFlowTheme.of(context).bodySmall.override(color: FlutterFlowTheme.of(context).secondaryText))),
                                                                Text(valueOrDefault<String>(functions.calculateAgeFromBirthdayString(listViewDogsRow.dogBirthday!),'N/A',), style: FlutterFlowTheme.of(context).bodySmall.override(fontFamily: GoogleFonts.inter().fontFamily, color: FlutterFlowTheme.of(context).secondaryText, fontSize: 12.0, letterSpacing: 0.0,),),
                                                              ],
                                                            ),
                                                            Text(
                                                              valueOrDefault<String>(listViewDogsRow.dogBirthday,'-',),
                                                              style: FlutterFlowTheme.of(context).bodySmall.override( // CORRECTED HERE
                                                                fontFamily: GoogleFonts.inter().fontFamily,
                                                                color: FlutterFlowTheme.of(context).accent2,
                                                                fontSize: 11.0,
                                                                letterSpacing: 0.0,
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(height: 3)),
                                                        ),
                                                      ),
                                                      Icon(Icons.chevron_right_rounded, color: FlutterFlowTheme.of(context).secondaryText, size: 24.0),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.bottomNavigationBarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: BottomNavigationBarWidget(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}