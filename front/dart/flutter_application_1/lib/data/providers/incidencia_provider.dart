import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/incidencia/incidencia.dart';
import 'package:flutter_application_1/data/repositories/incidenciaRepository.dart';

class IncidenciaProvider extends ChangeNotifier{
  final IncidenciaRepository repository;

  IncidenciaProvider(this.repository);

  List<Incidencia> _incidencias = [];
  bool _isLoading = false;
  bool _isCreating = false;
  String _error = "";

  List<Incidencia> get incidencias => _incidencias;
  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String get error => _error;

  Future<bool> createIncidencia(String titulo, String descripcion, int usuarioId, String token) async{
    _isCreating = true;
    notifyListeners();

    final response = await repository.createIncidencia(titulo, descripcion, "PENDIENTE", usuarioId, token);

    _isCreating = false;
    notifyListeners();

    if (response == 200) {
      getActiveIncidencias(token);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> getActiveIncidencias(String token) async{
    try{
      _isLoading = true;
      notifyListeners();

      final response = await repository.getActiveIncidencias(token);

      _incidencias = response.incidencias;
    }catch(e){
      _error = e.toString();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeState(int id, String token) async{
    final response = await repository.changeState(id, token);

    if (response == 200) {
      getActiveIncidencias(token);
      notifyListeners();
    }
  }

  Future<bool> deleteIncidencia(int id, String token) async {
    final response = await repository.deleteIncidencia(id, token);

    if (response == 200) {
      _incidencias.removeWhere((i) => i.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }
}