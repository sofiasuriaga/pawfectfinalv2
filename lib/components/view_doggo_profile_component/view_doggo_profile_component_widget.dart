import '/backend/supabase/supabase.dart';
import '/components/add_album/add_album_widget.dart';
import '/components/add_photo_in_album_component/add_photo_in_album_component_widget.dart';
import '/components/delete_album_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'view_doggo_profile_component_model.dart';
export 'view_doggo_profile_component_model.dart';

class ViewDoggoProfileComponentWidget extends StatefulWidget {
  const ViewDoggoProfileComponentWidget({
    super.key,
    required this.dog,
  });

  final DogsRow? dog;

  @override
  State<ViewDoggoProfileComponentWidget> createState() =>
      _ViewDoggoProfileComponentWidgetState();
}

class _ViewDoggoProfileComponentWidgetState
    extends State<ViewDoggoProfileComponentWidget> {
  late ViewDoggoProfileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewDoggoProfileComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    // Handle cases where widget.dog might be null, though less likely if always passed
    final dogData = widget.dog;
    if (dogData == null) {
      return Center(child: Text('Dog data not available.', style: FlutterFlowTheme.of(context).bodyMedium));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
              child: Container(
                width: 500.0,
                height: 601.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Color(0x33000000),
                      offset: Offset(0.0, 2.0,),
                    )
                  ],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(20.0, 80.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  valueOrDefault<String>(dogData.dogName, '-'),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    color: FlutterFlowTheme.of(context).success,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                                Text(
                                  valueOrDefault<String>(dogData.dogGender, '-'),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    color: FlutterFlowTheme.of(context).success,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                    child: Container(
                                      width: 120.0,
                                      height: 20.0,
                                      decoration: BoxDecoration(color: FlutterFlowTheme.of(context).success, borderRadius: BorderRadius.circular(100.0),),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.cake, color: FlutterFlowTheme.of(context).secondaryBackground, size: 16.0,),
                                          Text(
                                            valueOrDefault<String>(dogData.dogBirthday, '-'),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w500,).fontFamily,
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              fontSize: 12.0, letterSpacing: 0.0, fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 4.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                    child: Container(
                                      width: 70.0,
                                      height: 20.0,
                                      decoration: BoxDecoration(color: FlutterFlowTheme.of(context).primary, borderRadius: BorderRadius.circular(100.0),),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            valueOrDefault<String>(
                                              functions.calculateAgeFromBirthdayString(dogData.dogBirthday!), // Changed from dogAge
                                              'N/A', // Provide a sensible default if birthday is null
                                            ),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w500,).fontFamily,
                                              color: Colors.white,
                                              fontSize: 12.0, letterSpacing: 0.0, fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 4.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                    child: Container(
                                      width: 100.0,
                                      height: 20.0,
                                      decoration: BoxDecoration(color: FlutterFlowTheme.of(context).warning, borderRadius: BorderRadius.circular(100.0),),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Weight: ${valueOrDefault<String>(dogData.weight?.toString(), '-')}kg',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w500,).fontFamily,
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              fontSize: 12.0, letterSpacing: 0.0, fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 4.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 5.0)),
                            ),
                          ].divide(SizedBox(width: 4.0)),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Padding( // Added padding for better layout
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            valueOrDefault<String>(dogData.dogNote, '-'),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ALBUMS', style: FlutterFlowTheme.of(context).titleMedium.override(fontFamily: GoogleFonts.interTight().fontFamily, letterSpacing: 0.0,),),
                            if ((FFAppState().usertype == 'Admin') || (FFAppState().usertype == 'Owner'))
                              Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    await showDialog(context: context, builder: (dialogContext) {
                                      return Dialog(elevation: 0, insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                        child: AddAlbumWidget(dogId: dogData.id,), // Use dogData.id
                                      );},);},
                                  text: 'Add Album',
                                  icon: Icon(Icons.image, size: 15.0,),
                                  options: FFButtonOptions(height: 40.0, padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0), iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0), color: FlutterFlowTheme.of(context).success, textStyle: FlutterFlowTheme.of(context).titleSmall.override(fontFamily: GoogleFonts.interTight().fontFamily, color: Colors.white, letterSpacing: 0.0,), elevation: 0.0, borderRadius: BorderRadius.circular(8.0),),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded( // Make the album list scrollable if it overflows
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0), // Adjusted top padding
                          child: Container(
                            decoration: BoxDecoration(),
                            child: FutureBuilder<List<AlbumsRow>>(
                              future: AlbumsTable().queryRows(queryFn: (q) => q.eq('dog_id', dogData.id,),), // Use dogData.id
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: SizedBox(width: 50.0, height: 50.0, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary,),),),);
                                }
                                List<AlbumsRow> listViewAlbumsRowList = snapshot.data!;
                                if (listViewAlbumsRowList.isEmpty) {
                                  return Center(child: Text("No albums yet.", style: FlutterFlowTheme.of(context).bodyMedium));
                                }
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  // shrinkWrap: true, // Removed as it's inside Expanded
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewAlbumsRowList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewAlbumsRow = listViewAlbumsRowList[listViewIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0), // Added bottom padding
                                      child: Container(
                                        width: double.infinity, // Changed from 436.9
                                        height: 100.0,
                                        decoration: BoxDecoration(color: Color(0xFFF0F0F0),),
                                        child: Stack(
                                          children: [
                                            Builder(
                                              builder: (context) => InkWell(
                                                onTap: () async { await showDialog(context: context, builder: (dialogContext) { return Dialog(elevation: 0, insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)), child: AddPhotoInAlbumComponentWidget(album: listViewAlbumsRow,),);},);},
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Image.asset('assets/images/blue.png', width: double.infinity, height: double.infinity, fit: BoxFit.cover,),
                                                ),
                                              ),
                                            ),
                                            Align(alignment: AlignmentDirectional(0.0, 0.0), child: Text(valueOrDefault<String>(listViewAlbumsRow.albumName, '-'), style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w600,).fontFamily, color: Colors.white, fontSize: 20.0, letterSpacing: 0.0, fontWeight: FontWeight.w600,),),),
                                            Align(alignment: AlignmentDirectional(1.0, 0.0), child: Builder(builder: (context) => Padding(padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 70.0, 0.0), child: InkWell(onTap: () async { await showDialog(context: context, builder: (dialogContext) { return Dialog(elevation: 0, insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)), child: AddPhotoInAlbumComponentWidget(album: listViewAlbumsRow,),);},);}, child: Icon(Icons.remove_red_eye, color: Colors.white, size: 24.0,),),),),),
                                            if ((FFAppState().usertype == 'Admin') || (FFAppState().usertype == 'Owner'))
                                              Align(alignment: AlignmentDirectional(1.0, 0.0), child: Builder(builder: (context) => Padding(padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0), child: InkWell(onTap: () async { await showDialog(context: context, builder: (dialogContext) { return Dialog(elevation: 0, insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent, alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)), child: DeleteAlbumComponentWidget(id: listViewAlbumsRow.id,),);},);}, child: Icon(Icons.delete, color: FlutterFlowTheme.of(context).error, size: 40.0,),),),),),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 20.0,
                    decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground,),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.18, -1.12), // This positions the dog image overlay
              child: Container(
                width: 100.0, // Increased size for visibility
                height: 100.0, // Increased size for visibility
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3) // Added border
                ),
                child: Image.network(
                  dogData.dogImageUrl != null && dogData.dogImageUrl!.isNotEmpty
                      ? dogData.dogImageUrl!
                      : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/paw-fect-care-f0aaw3/assets/x0on0kdf9y35/default_dog_image.png', // Default image
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/default_dog_image.png'),
                ),
              ),
            ),
            Positioned( // Use Positioned for the close button within the Stack
              top: 15, right: 25,
              child: FFButtonWidget(
                onPressed: () async { Navigator.pop(context); },
                text: '', // Removed text to make it icon only
                icon: Icon(Icons.close_sharp, color: Colors.white, size: 24.0), // Made icon larger and white for better visibility
                options: FFButtonOptions(
                  width: 40.0, height: 40.0, // Made button circular
                  padding: EdgeInsets.zero,
                  color: FlutterFlowTheme.of(context).error, // Changed color for contrast
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(30.0), // Circular button
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}