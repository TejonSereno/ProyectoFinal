import 'dart:convert';

import 'package:flutter_application_1/data/model/incidencia/incidencia_list.dart';
import 'package:http/http.dart' as http;

class IncidenciaRepository {
  final String url = "https://proyectofinal-ujbs.onrender.com";

  Future createIncidencia(String titulo, String descripcion, String estado, int usuarioId, String token) async{
    final response = await http.post(
      Uri.parse("$url/incidencias"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "titulo": titulo,
        "descripcion": descripcion,
        "estado": estado,
        "usuarioId": usuarioId,
        "comunidadId": 1
      }),
    );

    return response.statusCode;
  }

  Future getActiveIncidencias(String token) async{
    final response = await http.get(
      Uri.parse("$url/incidencias/recientes"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return Incidencialist.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future changeState(int incidenciaId, String token) async{
    final response = await http.post(
      Uri.parse("$url/incidencias/$incidenciaId/estado"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future deleteIncidencia(int incidenciaId, String token) async{
    final response = await http.delete(
      Uri.parse("$url/incidencias/$incidenciaId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }
}