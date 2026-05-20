import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/usuario/usuario_list.dart';
import 'package:flutter_application_1/data/model/usuario/usuario.dart';
import 'package:flutter_application_1/data/repositories/repository.dart';

class UsuarioProvider extends ChangeNotifier{
  final Repository repository;

  UsuarioProvider(this.repository);

  List<Usuario> _usuarios = [];
  bool _isLoading = false;
  String _error = "";

  List<Usuario> get usuarios => _usuarios;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> getUsuarios() async{
    _isLoading = true;
    notifyListeners();

    final response = await repository.getUsuarios();

    if (response is UsuarioList) {
      _usuarios = response.usuarios;
      _error = "";
    } else {
      _error = response.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> chageRole(int id) async {
    final response = await repository.changeRole(id);

    if (response == 200) {
      getUsuarios();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> deleteUsuario(int id) async {
    final response = await repository.deleteUsuario(id);

    if (response == 200) {
      _usuarios.removeWhere((u) => u.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> updateUsuario(int id, String nombre, String email, String password) async {
    final response = await repository.updateUsuario(id, nombre, email, password);    

    if (response == 200) {
      
      return true;
    }

    return false;
  }
}