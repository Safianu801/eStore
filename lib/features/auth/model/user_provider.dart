import 'package:e_store/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel(
    userID: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    cart: [],
  );

  String? _loggedInUserId;

  UserModel get userModel => _userModel;

  String? get loggedInUserId => _loggedInUserId;

  void setUser(String user) {
    _userModel = UserModel.fromJson(user);
    _loggedInUserId = _userModel.userID;
    notifyListeners();
  }

  void setUserFromModel(UserModel userModel) {
    _userModel = userModel;
    _loggedInUserId = userModel.userID;
    notifyListeners();
  }
}
