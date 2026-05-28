import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/usuario/usuario.dart';
import 'package:flutter_application_1/data/repositories/usuarioRepository.dart';

class UsuarioProvider extends ChangeNotifier{
  final UsuarioRepository repository;

  UsuarioProvider(this.repository);

  List<Usuario> _usuarios = [];
  bool _isLoading = false;
  String _error = "";

  List<Usuario> get usuarios => _usuarios;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> getUsuarios(String token) async{
    try{
      _isLoading = true;
      notifyListeners();

      final response = await repository.getUsuarios(token);

      _usuarios = response.usuarios;
    }catch(e){
      _error = e.toString();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> chageRole(int id, String token) async {
    final response = await repository.changeRole(id, token);

    if (response == 200) {
      getUsuarios(token);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> deleteUsuario(int id,String token) async {
    final response = await repository.deleteUsuario(id, token);

    if (response == 200) {
      _usuarios.removeWhere((u) => u.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> updateUsuario(int id, String nombre, String email, String password, String token) async {
    final response = await repository.updateUsuario(id, nombre, email, password, token);    

    print(response);
    
    if (response >= 200 && response < 300 ) {
      
      return true;
    }

    return false;
  }
}