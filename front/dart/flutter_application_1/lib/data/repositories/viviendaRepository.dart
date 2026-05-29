import 'dart:convert';

import 'package:flutter_application_1/data/model/vivienda/viviendaDetalle.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/data/model/vivienda/vivienda_list.dart';

class ViviendaRepository {
  final String url = "https://proyectofinal-ujbs.onrender.com";

  Future getViviendas(String token) async{

    final response = await http.get(
      Uri.parse("$url/viviendas/listado"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return ViviendaList.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future getViviendaDetalle(int id, String token) async{
    final response = await http.get(
      Uri.parse("$url/viviendas/$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return ViviendaDetalle.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future putNewVivienda(String calle, String numero, String token) async{
    final response = await http.post(
      Uri.parse("$url/viviendas"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "calle": calle,
        "numero": numero,
        "comunidadId": 1
      }),
    );

    return response.statusCode;
  }

  Future deleteVivienda(int viviendaId, String token) async{
    final response = await http.delete(
      Uri.parse("$url/viviendas/$viviendaId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }
}