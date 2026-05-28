import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/loguin/user.dart';
import 'package:flutter_application_1/data/model/vivienda/vivienda.dart';
import 'package:flutter_application_1/data/repositories/authRepository.dart';

class UserProvider with ChangeNotifier {
  User? user;
  String? token;

  final Authrepository _authRepository;

  UserProvider(this._authRepository);

  Future<void> login(String email, String password) async {
    try {
      final loginResponse =
          await _authRepository.getlogin(email, password);

      user = loginResponse.usuario;
      token = loginResponse.token;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void setAuth({required User u, required String t}) {
    user = u;
    token = t;
    notifyListeners();
  }

  void setUser(User u) {
    user = u;
    notifyListeners();
  }

  void setToken(String t) {
    token = t;
    notifyListeners();
  }

  void clearUser() {
    user = null;
    notifyListeners();
  }

  void updateUser({required String nombre, required String email,}) {
    if (user == null) return;

    user = user!.copyWith(
      nombre: nombre,
      email: email,
    );

    notifyListeners();
  }
}