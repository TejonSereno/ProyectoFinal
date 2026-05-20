import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/votacion/Votacion.dart';
import 'package:flutter_application_1/data/model/votacion/votacion_detalle.dart';
import 'package:flutter_application_1/data/model/votacion/votacion_list.dart';
import 'package:flutter_application_1/data/model/voto/voto.dart';
import 'package:flutter_application_1/data/repositories/repository.dart';

class VotacionProvider extends ChangeNotifier{
  final Repository repository;

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

  Future<void> getVotaciones() async{
    _isLoading = true;
    notifyListeners();

    final response = await repository.getActiveVotaciones();

    if (response is Votacionlist) {
      _votaciones = response.votaciones;
      _error = "";
    } else {
      _error = response.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createVotacion(String titulo, String descripcion, DateTime fechaFin, List<String> opciones) async {
    _isCreating = true;
    notifyListeners();

    final response = await repository.createVotacion(titulo, descripcion, fechaFin, opciones);

    _isCreating = false;
    notifyListeners();

    if (response == 200) {
      getVotaciones();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> deleteVotacion(int id) async {
    final response = await repository.deleteVotacion(id);

    if (response == 200) {
      _votaciones.removeWhere((v) => v.id == id);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> getVotacionDetalle(int id) async{
    _isLoading = true;
    notifyListeners();

    final response = await repository.getVotacionDetalle(id);

    if (response is VotacionDetalle) {
      _votaciondetalle = response;
      _error = "";
    } else {
      _error = response.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> hasVoted(int userId, int votacionId) async {
    _isLoading = true;
    notifyListeners();
    
    _voto = null;

    final response = await repository.getVoto(userId, votacionId);

    if (response is Voto) {
      _voto = response;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> votar(int userId, int votacionId, String opcion) async{
    final response = await repository.votar(userId, votacionId, opcion);

    if (response is Voto) {
      _voto = response;

      await getVotacionDetalle(votacionId);

      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}