import '/backend/supabase/supabase.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            const _BackgroundImage(),
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Column(
                children: [
                  const _HeaderSection(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: _FeedChartContent(model: _model, onPerformFiltering: _performFiltering),
                    ),
                  ),
                ],
              ),
            ),
            _BottomNavigation(model: _model),
          ],
        ),
      ),
    );
  }
}

// Extracted background image widget
class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        'assets/images/blue.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

// Extracted header section
class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
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
          Padding(
            padding: const EdgeInsets.only(top: 25.0, right: 15.0),
            child: Icon(
              Icons.notifications_sharp,
              color: FlutterFlowTheme.of(context).warning,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}

// Extracted feed chart content
class _FeedChartContent extends StatelessWidget {
  final FeedChartPageModel model;
  final VoidCallback onPerformFiltering;

  const _FeedChartContent({
    required this.model,
    required this.onPerformFiltering,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FeedChartsRow>>(
      future: FeedChartsTable().queryRows(queryFn: (q) => q),
      builder: (context, feedChartsSnapshot) {
        if (!feedChartsSnapshot.hasData) {
          return const _LoadingIndicator();
        }

        model.allFeedCharts = feedChartsSnapshot.data!;

        return Container(
          width: 355.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            children: [
              const _FeedChartHeader(),
              _SearchField(controller: model.searchController),
              Expanded(
                child: _DogsList(
                  model: model,
                  onPerformFiltering: onPerformFiltering,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Extracted loading indicator
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
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
}

// Extracted feed chart header
class _FeedChartHeader extends StatelessWidget {
  const _FeedChartHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355.8,
      height: 63.4,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFD8205), Colors.white],
          stops: [0.0, 1.0],
          begin: AlignmentDirectional(0.0, -1.0),
          end: AlignmentDirectional(0, 1.0),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart_rounded,
            color: FlutterFlowTheme.of(context).success,
            size: 30.0,
          ),
          const SizedBox(width: 10.0),
          Text(
            'Feed Chart',
            style: FlutterFlowTheme.of(context).titleMedium.override(
              fontFamily: GoogleFonts.interTight().fontFamily,
              color: FlutterFlowTheme.of(context).success,
              fontSize: 22.0,
              letterSpacing: 0.0,
            ),
          ),
          const SizedBox(width: 10.0),
          Icon(
            Icons.bar_chart_rounded,
            color: FlutterFlowTheme.of(context).success,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}

// Extracted search field
class _SearchField extends StatelessWidget {
  final TextEditingController? controller;

  const _SearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Search dogs...',
              hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w500).fontFamily,
                color: Colors.grey[600],
                letterSpacing: 0.0,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 12.0),
              suffixIcon: Icon(
                Icons.search_outlined,
                color: FlutterFlowTheme.of(context).success,
                size: 22.0,
              ),
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: GoogleFonts.inter().fontFamily,
              color: Colors.black,
              letterSpacing: 0.0,
            ),
          ),
        ),
      ),
    );
  }
}

// Extracted dogs list
class _DogsList extends StatelessWidget {
  final FeedChartPageModel model;
  final VoidCallback onPerformFiltering;

  const _DogsList({
    required this.model,
    required this.onPerformFiltering,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DogsRow>>(
      future: DogsTable().queryRows(
        queryFn: (q) => q.order('dog_name', ascending: true),
      ),
      builder: (context, dogsSnapshot) {
        if (!dogsSnapshot.hasData) {
          return const _LoadingIndicator();
        }

        bool listDataHasChanged = !const DeepCollectionEquality()
            .equals(model.allDogs, dogsSnapshot.data!);

        if (listDataHasChanged) {
          model.allDogs = dogsSnapshot.data!;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onPerformFiltering();
          });
        } else if (model.filteredDogs.isEmpty &&
            model.searchQuery.isEmpty &&
            model.allDogs.isNotEmpty &&
            model.allDogs.length != model.filteredDogs.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onPerformFiltering();
          });
        }

        final dogsToDisplay = model.searchQuery.isEmpty
            ? model.allDogs
            : model.filteredDogs;

        return _DogsListView(
          dogs: dogsToDisplay,
          searchQuery: model.searchQuery,
          allFeedCharts: model.allFeedCharts,
        );
      },
    );
  }
}

// Extracted dogs list view
class _DogsListView extends StatelessWidget {
  final List<DogsRow> dogs;
  final String searchQuery;
  final List<FeedChartsRow> allFeedCharts;

  const _DogsListView({
    required this.dogs,
    required this.searchQuery,
    required this.allFeedCharts,
  });

  @override
  Widget build(BuildContext context) {
    if (dogs.isEmpty && searchQuery.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          'No dogs found for "$searchQuery".',
          style: FlutterFlowTheme.of(context).bodyMedium,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (dogs.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          'No dogs available.',
          style: FlutterFlowTheme.of(context).bodyMedium,
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      itemCount: dogs.length,
      itemBuilder: (context, index) => _DogListItem(
        dog: dogs[index],
        allFeedCharts: allFeedCharts,
      ),
    );
  }
}

// Extracted dog list item
class _DogListItem extends StatelessWidget {
  final DogsRow dog;
  final List<FeedChartsRow> allFeedCharts;

  const _DogListItem({
    required this.dog,
    required this.allFeedCharts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: InkWell(
        onTap: () => context.pushNamed(
          ExpandDogFoodWidget.routeName,
          queryParameters: {
            'dog': serializeParam(dog, ParamType.SupabaseRow),
            'recipe': serializeParam(
              allFeedCharts,
              ParamType.SupabaseRow,
              isList: true,
            ),
          }.withoutNulls,
        ),
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 3.0,
                color: Color(0x33000000),
                offset: Offset(0.0, 1.0),
              )
            ],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                _DogAvatar(dog: dog),
                const SizedBox(width: 12),
                Expanded(child: _DogInfo(dog: dog)),
                Icon(
                  Icons.chevron_right_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Extracted dog avatar
class _DogAvatar extends StatelessWidget {
  final DogsRow dog;

  const _DogAvatar({required this.dog});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Image.network(
        dog.dogImageUrl != null && dog.dogImageUrl!.isNotEmpty
            ? dog.dogImageUrl!
            : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/paw-fect-care-f0aaw3/assets/x0on0kdf9y35/default_dog_image.png',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset('assets/images/default_dog_image.png'),
      ),
    );
  }
}

// Extracted dog info
class _DogInfo extends StatelessWidget {
  final DogsRow dog;

  const _DogInfo({required this.dog});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dog.dogName,
          style: FlutterFlowTheme.of(context).titleSmall.override(
            fontFamily: GoogleFonts.interTight().fontFamily,
            color: FlutterFlowTheme.of(context).primary,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          valueOrDefault<String>(dog.dogGender, '-'),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: GoogleFonts.inter().fontFamily,
            color: FlutterFlowTheme.of(context).success,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          valueOrDefault<String>(dog.dogBirthday, '-'),
          style: FlutterFlowTheme.of(context).bodySmall.override(
            fontFamily: GoogleFonts.interTight().fontFamily,
            color: FlutterFlowTheme.of(context).secondaryText,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          valueOrDefault<String>(dog.dogAge, '-'),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: GoogleFonts.inter().fontFamily,
            letterSpacing: 0.0,
          ),
        ),
      ],
    );
  }
}

// Extracted bottom navigation
class _BottomNavigation extends StatelessWidget {
  final FeedChartPageModel model;

  const _BottomNavigation({required this.model});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: wrapWithModel(
        model: model.bottomNavigationBarModel,
        updateCallback: () => {},
        child: const BottomNavigationBarWidget(),
      ),
    );
  }
}