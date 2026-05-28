import 'dart:convert';

import 'package:flutter_application_1/data/model/aviso/aviso_list.dart';
import 'package:http/http.dart' as http;

class AvisoRepository {
  final String url = "https://proyectofinal-ujbs.onrender.com";

  Future getAvisosActivos(String token) async{

    final response = await http.get(
      Uri.parse("$url/avisos/activos"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return AvisoList.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future createAviso(String titulo, String descripcion, DateTime fechaFin, String token) async{
    final response = await http.post(
      Uri.parse("$url/avisos"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "titulo": titulo,
          "descripcion": descripcion,
          "fechaFin": fechaFin.toIso8601String(),
          "comunidadId": 1
        }
      )
    );

    return response.statusCode;
  }

  Future deleteAviso(int avisoId, String token) async{
    final response = await http.delete(
      Uri.parse("$url/avisos/$avisoId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }
}