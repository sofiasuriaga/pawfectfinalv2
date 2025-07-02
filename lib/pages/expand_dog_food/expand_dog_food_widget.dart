import '/backend/supabase/supabase.dart';
import '/components/add_dog_food_component/add_dog_food_component_widget.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '/components/delete_dog_food_component_widget.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'expand_dog_food_model.dart';
export 'expand_dog_food_model.dart';

class ExpandDogFoodWidget extends StatefulWidget {
  const ExpandDogFoodWidget({
    super.key,
    required this.dog,
    required this.recipe,
  });

  final DogsRow? dog;
  final List<FeedChartsRow>? recipe;

  static String routeName = 'ExpandDogFood';
  static String routePath = '/expandDogFood';

  @override
  State<ExpandDogFoodWidget> createState() => _ExpandDogFoodWidgetState();
}

class _ExpandDogFoodWidgetState extends State<ExpandDogFoodWidget> {
  late ExpandDogFoodModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExpandDogFoodModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            Image.asset(
              'assets/images/blue.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Column(
                children: [
                  // Header Section
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 15.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/logo_transparent.png',
                          width: 100.0,
                          height: 100.0,
                        ),
                        Icon(
                          Icons.notifications_sharp,
                          color: FlutterFlowTheme.of(context).warning,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),

                  // Dog Info Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            widget.dog?.dogImageUrl != null && widget.dog!.dogImageUrl!.isNotEmpty
                                ? widget.dog!.dogImageUrl!
                                : 'https://images.unsplash.com/photo-1531969179221-3946e6b5a5e7?auto=format',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    valueOrDefault<String>(widget.dog?.dogName, '-'),
                                    style: FlutterFlowTheme.of(context).headlineSmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(widget.dog?.dogGender, '-'),
                                    style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    valueOrDefault<String>(widget.dog?.dogBirthday, '-'),
                                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(widget.dog?.dogAge, '-'),
                                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content Section
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Header with Add Button
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Chart Recipe',
                                  style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                                    color: const Color(0xFF249689),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (FFAppState().usertype == 'Owner')
                                  InkWell(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            height: 500,
                                            width: 500,
                                            child: AddDogFoodComponentWidget(addDogFood: widget.dog!),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).warning,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: FlutterFlowTheme.of(context).warning.withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Recipe List
                          Expanded(
                            child: FutureBuilder<List<FeedChartsRow>>(
                              future: widget.dog?.id == null
                                  ? Future.value(<FeedChartsRow>[])
                                  : FeedChartsTable().queryRows(
                                queryFn: (q) => q.eq('feed_charts_dog_id', widget.dog!.id!),
                              ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(child: CircularProgressIndicator());
                                }

                                if (snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.pets,
                                          size: 80,
                                          color: Colors.grey[400],
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No recipes added yet',
                                          style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final row = snapshot.data![index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 16.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.08),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Recipe Name and Delete Button
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFF249689),
                                                        borderRadius: BorderRadius.circular(20.0),
                                                      ),
                                                      child: Text(
                                                        row.chartRecipe ?? 'Unknown Recipe',
                                                        style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (FFAppState().usertype == 'Owner') ...[
                                                    const SizedBox(width: 12),
                                                    InkWell(
                                                      onTap: () async {
                                                        await showDialog(
                                                          context: context,
                                                          builder: (_) => Dialog(
                                                            backgroundColor: Colors.transparent,
                                                            child: DeleteDogFoodComponentWidget(id: row.id),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.red.withOpacity(0.1),
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        child: const Icon(
                                                          Icons.delete_outline,
                                                          color: Colors.red,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),

                                              const SizedBox(height: 16),

                                              // Dosage and Frequency
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Dosage',
                                                          style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                                            color: Colors.grey[600],
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          row.chartDosage ?? 'Not specified',
                                                          style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.black87,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Frequency',
                                                          style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                                            color: Colors.grey[600],
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          row.chartFrequency ?? 'Not specified',
                                                          style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.black87,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Navigation
            Align(
              alignment: Alignment.bottomCenter,
              child: wrapWithModel(
                model: _model.bottomNavigationBarModel,
                updateCallback: () => setState(() {}),
                child: BottomNavigationBarWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}