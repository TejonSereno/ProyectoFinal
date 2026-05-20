import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/incidencia/incidencia_list.dart';
import 'package:flutter_application_1/data/model/incidencia/incidencia.dart';
import 'package:flutter_application_1/data/repositories/repository.dart';

class IncidenciaProvider extends ChangeNotifier{
  final Repository repository;

  IncidenciaProvider(this.repository);

  List<Incidencia> _incidencias = [];
  bool _isLoading = false;
  bool _isCreating = false;
  String _error = "";

  List<Incidencia> get incidencias => _incidencias;
  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String get error => _error;

  Future<bool> createIncidencia(String titulo, String descripcion, int usuarioId) async{
    _isCreating = true;
    notifyListeners();

    final response = await repository.createIncidencia(titulo, descripcion, "PENDIENTE", usuarioId);

    _isCreating = false;
    notifyListeners();

    if (response == 200) {
      getActiveIncidencias();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> getActiveIncidencias() async{
    _isLoading = true;
    notifyListeners();

    final response = await repository.getActiveIncidencias();

    if (response is Incidencialist) {
      _incidencias = response.incidencias;
      _error = "";
    } else {
      _error = response.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
  Future<void> changeState(int id) async{
    final response = await repository.changeState(id);

    if (response == 200) {
      getActiveIncidencias();
      notifyListeners();
    }
  }

  Future<bool> deleteIncidencia(int id) async {
    final response = await repository.deleteIncidencia(id);

    if (response == 200) {
      _incidencias.removeWhere((i) => i.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }
}