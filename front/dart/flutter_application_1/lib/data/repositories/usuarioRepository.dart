import 'dart:convert';

import 'package:flutter_application_1/data/model/usuario/usuario_list.dart';
import 'package:http/http.dart' as http;

class UsuarioRepository {
  final String url = "https://proyectofinal-ujbs.onrender.com";

  Future getUsuarios(String token) async{
    final response = await http.get(
      Uri.parse("$url/usuarios/listado"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return UsuarioList.fromJson(decodeJson);
    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future deleteUsuario(int usuarioId, String token) async{
    final response = await http.delete(
      Uri.parse("$url/usuarios/$usuarioId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future changeRole(int usuarioId, String token) async{
    final response = await http.post(
      Uri.parse("$url/usuarios/$usuarioId/rol"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future updateUsuario(int id, String nombre,String email, String password, String token) async{
    Map<String, dynamic> body = {
      "nombre": nombre,
      "email": email,
    };

    if(password.isNotEmpty){
      body["password"] = password;
    }

    final response = await http.put(
      Uri.parse("$url/usuarios/$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response.statusCode;
  }
}