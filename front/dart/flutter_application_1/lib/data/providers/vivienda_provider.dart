import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/vivienda/vivienda.dart';
import 'package:flutter_application_1/data/model/vivienda/viviendaDetalle.dart';
import 'package:flutter_application_1/data/repositories/viviendaRepository.dart';

class ViviendaProvider extends ChangeNotifier{
  final ViviendaRepository repository;

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

  Future<void> getViviendas(String token) async{
    try{
      _isLoading = true;
      notifyListeners();

      final response = await repository.getViviendas(token);

      _viviendas = response.viviendas;
    }catch(e){
      _error = e.toString();
    }finally{
      _isLoading = false;
    notifyListeners();
    }
    
  }

  Future<bool> createVivienda(String calle, String numero, String token) async {
    _isCreating = true;
    notifyListeners();

    final response = await repository.putNewVivienda(calle, numero, token);

    _isCreating = false;

    if (response == 200) {
      getViviendas(token);
      notifyListeners();
      return true;  
    }

    notifyListeners();
    return false;
  }

  Future<bool> deleteVivienda(int id, String token) async {
    final response = await repository.deleteVivienda(id, token);

    if (response == 200) {
      _viviendas.removeWhere((v) => v.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> getViviendaDetalle(int id, String token) async{
    try{
      _isLoading = true;
      notifyListeners();
      

      final response = await repository.getViviendaDetalle(id, token);

      _viviendaDetalle = response;
    
    }catch(e){
      _error = e.toString();
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}