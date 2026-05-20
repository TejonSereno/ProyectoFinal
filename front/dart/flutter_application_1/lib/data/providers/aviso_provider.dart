import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/aviso/aviso.dart';
import 'package:flutter_application_1/data/model/aviso/aviso_list.dart';
import 'package:flutter_application_1/data/repositories/repository.dart';

class AvisoProvider extends ChangeNotifier {
  final Repository repository;

  AvisoProvider(this.repository);

  List<Aviso> _avisos = [];
  bool _isLoading = false;
  bool _isCreating = false;
  String _error = "";

  List<Aviso> get avisos => _avisos;
  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String get error => _error;

  Future<void> getAvisos() async{
    _isLoading = true;
    notifyListeners();

    final response = await repository.getAvisosActivos();

    if (response is AvisoList) {
      _avisos = response.avisos;
      _error = "";
    } else {
      _error = response.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createAviso(String titulo, String descripcion, DateTime fechaFin) async{
    _isCreating = true;
    notifyListeners();

    final response = await repository.createAviso(titulo, descripcion, fechaFin);

    _isCreating = false;
    notifyListeners();

    if (response == 200) {
      getAvisos();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> deleteAviso(int id) async{
    final response = await repository.deleteAviso(id);

    if (response == 200) {
      _avisos.removeWhere((v) => v.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }
}