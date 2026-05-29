import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/aviso/aviso.dart';
import 'package:flutter_application_1/data/repositories/avisoRepository.dart';

class AvisoProvider extends ChangeNotifier {
  final AvisoRepository repository;

  AvisoProvider(this.repository);

  List<Aviso> _avisos = [];
  bool _isLoading = false;
  bool _isCreating = false;
  String _error = "";

  List<Aviso> get avisos => _avisos;
  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String get error => _error;

  Future<void> getAvisos(String token) async{
    try{
      _isLoading = true;
      notifyListeners();

      final response = await repository.getAvisosActivos(token);

      _avisos = response.avisos;
    }catch(e){
      _error = e.toString().replaceFirst("Exception: ", "");
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createAviso(String titulo, String descripcion, DateTime fechaFin, String token) async{
    _isCreating = true;
    notifyListeners();

    final response = await repository.createAviso(titulo, descripcion, fechaFin, token);

    _isCreating = false;
    notifyListeners();

    if (response == 200) {
      getAvisos(token);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> deleteAviso(int id, String token) async{
    final response = await repository.deleteAviso(id, token);

    if (response == 200) {
      _avisos.removeWhere((v) => v.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }
}