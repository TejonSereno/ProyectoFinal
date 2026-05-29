import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/loguin/user.dart';
import 'package:flutter_application_1/data/repositories/authRepository.dart';

class UserProvider with ChangeNotifier {
  User? user;
  String? token;
  String _error = "";

  final Authrepository _authRepository;

  UserProvider(this._authRepository);

  String get error => _error;

  Future<void> login(String email, String password) async {
    try {
      _error = "";

      final loginResponse =
          await _authRepository.getlogin(email, password);

      user = loginResponse.usuario;
      token = loginResponse.token;

    } catch (e) {
      _error = e.toString().replaceFirst("Exception: ", "");

    }finally {

      notifyListeners();
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