import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/votacion/Votacion.dart';
import 'package:flutter_application_1/data/model/votacion/votacion_detalle.dart';
import 'package:flutter_application_1/data/model/voto/voto.dart';
import 'package:flutter_application_1/data/repositories/votacionRepository.dart';

class VotacionProvider extends ChangeNotifier{
  final VotacionRepository repository;

  VotacionProvider(this.repository);

  List<Votacion> _votaciones = [];
  VotacionDetalle _votaciondetalle = VotacionDetalle(0, "", "", DateTime.now(), {});
  Voto? _voto;
  bool _isLoading = false;
  bool _isCreating = false;
  String _error = "";

  List<Votacion> get votaciones => _votaciones;
  VotacionDetalle get votaciondetalle => _votaciondetalle;
  Voto? get voto => _voto;
  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String get error => _error;

  Future<void> getVotaciones(String token) async{
    try{
      _isLoading = true;
      notifyListeners();

      final response = await repository.getActiveVotaciones(token);

      _votaciones = response.votaciones;
    }catch(e){
      _error = e.toString();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createVotacion(String titulo, String descripcion, DateTime fechaFin, List<String> opciones, String token) async {
    _isCreating = true;
    notifyListeners();

    final response = await repository.createVotacion(titulo, descripcion, fechaFin, opciones, token);

    _isCreating = false;
    notifyListeners();

    if (response == 200) {
      getVotaciones(token);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> deleteVotacion(int id, String token) async {
    final response = await repository.deleteVotacion(id, token);

    if (response == 200) {
      _votaciones.removeWhere((v) => v.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> getVotacionDetalle(int id, String token) async{
    try{
      _isLoading = true;
       notifyListeners();

      final response = await repository.getVotacionDetalle(id, token);
      _votaciondetalle = response;
    }catch(e){
      _error = e.toString();
    }finally{
      _isLoading = false;
    notifyListeners();
    } 
  }

  Future<void> hasVoted(int userId, int votacionId, String token) async {
    _isLoading = true;
    notifyListeners();
    
    _voto = null;

    final response = await repository.getVoto(userId, votacionId, token);

    if (response is Voto) {
      _voto = response;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> votar(int userId, int votacionId, String opcion, String token) async{
    final response = await repository.votar(userId, votacionId, opcion, token);

    if (response is Voto) {
      _voto = response;

      await getVotacionDetalle(votacionId, token);

      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}