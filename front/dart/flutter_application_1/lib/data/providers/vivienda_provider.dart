import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/vivienda/vivienda.dart';
import 'package:flutter_application_1/data/model/vivienda/viviendaDetalle.dart';
import 'package:flutter_application_1/data/model/vivienda/vivienda_list.dart';
import 'package:flutter_application_1/data/repositories/repository.dart';

class ViviendaProvider extends ChangeNotifier{
  final Repository repository;

  ViviendaProvider(this.repository);

  List<Vivienda> _viviendas = [];
  ViviendaDetalle _viviendaDetalle = ViviendaDetalle(id: 0, calle: "", numero: "", usuarios: []);
  bool _isLoading = false;
  bool _isCreating = false;
  String _error = "";

  List<Vivienda> get viviendas => _viviendas;
  ViviendaDetalle get viviendaDetalle => _viviendaDetalle;
  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String get error => _error;

  Future<void> getViviendas() async{
    _isLoading = true;
    notifyListeners();

    final response = await repository.getViviendas();

    if (response is ViviendaList) {
      _viviendas = response.viviendas;
      _error = "";
    } else {
      _error = response.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createVivienda(String calle, String numero) async {
    _isCreating = true;
    notifyListeners();

    final response = await repository.putNewVivienda(calle, numero);

    _isCreating = false;

    if (response == 200) {
      getViviendas();
      notifyListeners();
      return true;  
    }

    notifyListeners();
    return false;
  }

  Future<bool> deleteVivienda(int id) async {
    final response = await repository.deleteVivienda(id);

    if (response == 200) {
      _viviendas.removeWhere((v) => v.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> getViviendaDetalle(int id) async{
    _isLoading = true;
    notifyListeners();


    final response = await repository.getViviendaDetalle(id);

    if (response is ViviendaDetalle) {
      _viviendaDetalle = response;

    } else {
      _error = response.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}