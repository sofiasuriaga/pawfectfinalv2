import '/backend/supabase/supabase.dart';
import '/components/success_component/success_component_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'add_dog_food_component_widget.dart' show AddDogFoodComponentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddDogFoodComponentModel
    extends FlutterFlowModel<AddDogFoodComponentWidget> {
  ///  Local state fields for this component.

  bool isSave = false;

  bool isClicked = false;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for dogfoodDescription widget.
  FocusNode? dogfoodDescriptionFocusNode;
  TextEditingController? dogfoodDescriptionTextController;
  String? Function(BuildContext, String?)?
      dogfoodDescriptionTextControllerValidator;
  // State field(s) for dogfoodQuantity widget.
  FocusNode? dogfoodQuantityFocusNode;
  TextEditingController? dogfoodQuantityTextController;
  String? Function(BuildContext, String?)?
      dogfoodQuantityTextControllerValidator;
  String? _dogfoodQuantityTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Add Quantity is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    dogfoodQuantityTextControllerValidator =
        _dogfoodQuantityTextControllerValidator;
  }

  @override
  void dispose() {
    dogfoodDescriptionFocusNode?.dispose();
    dogfoodDescriptionTextController?.dispose();

    dogfoodQuantityFocusNode?.dispose();
    dogfoodQuantityTextController?.dispose();
  }
}
