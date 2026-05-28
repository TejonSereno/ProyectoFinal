import 'dart:convert';

import 'package:flutter_application_1/data/model/votacion/votacion_detalle.dart';
import 'package:flutter_application_1/data/model/votacion/votacion_list.dart';
import 'package:flutter_application_1/data/model/voto/voto.dart';
import 'package:http/http.dart' as http;

class VotacionRepository{
  final String url = "https://proyectofinal-ujbs.onrender.com";

  Future createVotacion(String titulo, String descripcion, DateTime fechaFin, List<String> opciones, String token) async{
    final response = await http.post(
      Uri.parse("$url/votaciones"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "titulo": titulo,
        "descripcion": descripcion,
        "fechaFin": fechaFin.toIso8601String(),
        "opciones": opciones,
        "comunidadId": 1
      })
    );

    return response.statusCode;
  }

  Future getActiveVotaciones(String token) async{
    final response = await http.get(
      Uri.parse("$url/votaciones/recientes"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return Votacionlist.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future getVotacion(int votacionId, String token) async{
    final response = await http.get(
      Uri.parse("$url/votaciones/$votacionId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return VotacionDetalle.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future deleteVotacion(int votacionId, String token) async{
    final response = await http.delete(
      Uri.parse("$url/votaciones/$votacionId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future getVotacionDetalle(int votacionId, String token) async{
    final response = await http.get(
      Uri.parse("$url/votaciones/$votacionId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return VotacionDetalle.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future getVoto(int userId, int votacionId, String token) async{
    final response = await http.get(
      Uri.parse("$url/votos/$userId/$votacionId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return Voto.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future votar(int userId, int votacionId, String opcion, String token) async{
    final response = await http.post(
      Uri.parse("$url/votos"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "usuarioId": userId,
        "votacionId": votacionId,
        "opcion": opcion
      })
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return Voto.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }
}