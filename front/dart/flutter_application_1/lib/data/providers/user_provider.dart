import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/user.dart';

class UserProvider with ChangeNotifier {
  User? user;

  void setUser(User u) {
    user = u;
    notifyListeners();
  }

  void clearUser() {
    user = null;
    notifyListeners();
  }

  void updateUser({required String nombre, required String email, required String password}) {
    if (user == null) return;

    user = user!.copyWith(
      nombre: nombre,
      email: email,
      password: password
    );

    notifyListeners();
  }
}