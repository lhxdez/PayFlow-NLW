import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  var _isAuthenticated = false;
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      _isAuthenticated = true;

      Navigator.pushReplacementNamed(context, "/home");
    } else {
      _isAuthenticated = false;
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    // Salva o usuário logado, seta string com o nome do usuário
    final instance = await SharedPreferences.getInstance();

    await instance.setString("user", user.toJson());

    return;
  }

  Future<void> currentUser(BuildContext context) async {
    //ssss
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;

      setUser(context, UserModel.fromJson(json));

      return;
    } else {
      setUser(context, null);
    }
  }
}
