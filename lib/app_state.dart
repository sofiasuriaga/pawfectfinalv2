import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  AuthenticatedUserStruct _authenticatedUser = AuthenticatedUserStruct();
  AuthenticatedUserStruct get authenticatedUser => _authenticatedUser;
  set authenticatedUser(AuthenticatedUserStruct value) {
    _authenticatedUser = value;
  }

  void updateAuthenticatedUserStruct(
      Function(AuthenticatedUserStruct) updateFn) {
    updateFn(_authenticatedUser);
  }

  UserV3Struct _users = UserV3Struct();
  UserV3Struct get users => _users;
  set users(UserV3Struct value) {
    _users = value;
  }

  void updateUsersStruct(Function(UserV3Struct) updateFn) {
    updateFn(_users);
  }

  String _usertype = '';
  String get usertype => _usertype;
  set usertype(String value) {
    _usertype = value;
  }

  UserStruct _userrr = UserStruct();
  UserStruct get userrr => _userrr;
  set userrr(UserStruct value) {
    _userrr = value;
  }

  void updateUserrrStruct(Function(UserStruct) updateFn) {
    updateFn(_userrr);
  }

  Userv3Struct _userv3 = Userv3Struct();
  Userv3Struct get userv3 => _userv3;
  set userv3(Userv3Struct value) {
    _userv3 = value;
  }

  void updateUserv3Struct(Function(Userv3Struct) updateFn) {
    updateFn(_userv3);
  }

  bool _isFollowUpClicked = false;
  bool get isFollowUpClicked => _isFollowUpClicked;
  set isFollowUpClicked(bool value) {
    _isFollowUpClicked = value;
  }

  String _userid = '';
  String get userid => _userid;
  set userid(String value) {
    _userid = value;
  }

  String _uploadedImageUrl = '';
  String get uploadedImageUrl => _uploadedImageUrl;
  set uploadedImageUrl(String value) {
    _uploadedImageUrl = value;
  }

  bool _isFemaleClicked = false;
  bool get isFemaleClicked => _isFemaleClicked;
  set isFemaleClicked(bool value) {
    _isFemaleClicked = value;
  }

  String _userName = '';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
  }

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(String value) {
    _accessToken = value;
  }

  bool _userNotActive = false;
  bool get userNotActive => _userNotActive;
  set userNotActive(bool value) {
    _userNotActive = value;
  }

  String _fcmToken = '';
  String get fcmToken => _fcmToken;
  set fcmToken(String value) {
    _fcmToken = value;
  }

  List<String> _dogFood = ['Liver', 'Hotdog'];
  List<String> get dogFood => _dogFood;
  set dogFood(List<String> value) {
    _dogFood = value;
  }

  void addToDogFood(String value) {
    dogFood.add(value);
  }

  void removeFromDogFood(String value) {
    dogFood.remove(value);
  }

  void removeAtIndexFromDogFood(int index) {
    dogFood.removeAt(index);
  }

  void updateDogFoodAtIndex(
      int index,
      String Function(String) updateFn,
      ) {
    dogFood[index] = updateFn(_dogFood[index]);
  }

  void insertAtIndexInDogFood(int index, String value) {
    dogFood.insert(index, value);
  }

  String _userFcmToken = '';
  String get userFcmToken => _userFcmToken;
  set userFcmToken(String value) {
    _userFcmToken = value;
  }

  List<String> _assignedToUserToken = [];
  List<String> get assignedToUserToken => _assignedToUserToken;
  set assignedToUserToken(List<String> value) {
    _assignedToUserToken = value;
  }

  void addToAssignedToUserToken(String value) {
    assignedToUserToken.add(value);
  }

  void removeFromAssignedToUserToken(String value) {
    assignedToUserToken.remove(value);
  }

  void removeAtIndexFromAssignedToUserToken(int index) {
    assignedToUserToken.removeAt(index);
  }

  void updateAssignedToUserTokenAtIndex(
      int index,
      String Function(String) updateFn,
      ) {
    assignedToUserToken[index] = updateFn(_assignedToUserToken[index]);
  }

  void insertAtIndexInAssignedToUserToken(int index, String value) {
    assignedToUserToken.insert(index, value);
  }
}
