import 'dart:convert';

import 'package:flutter_application_1/data/model/loguin/LoguinResponse.dart';
import 'package:flutter_application_1/data/model/loguin/user.dart';
import 'package:http/http.dart' as http;

class Authrepository {
  final String url = "https://proyectofinal-ujbs.onrender.com";
  //final String url = "https://192.168.1.152:8080";

  Future getlogin(String email, String password) async{
    final response = await http.post(
      Uri.parse("$url/auth/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    
    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){

      return LoginResponse.fromJson(decodeJson);

    }else{
      throw Exception(decodeJson["message"]);
    }
  }

  Future getRegistre(User user, String password, int viviendaId) async{
    final response = await http.post(
      Uri.parse("$url/auth/register"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": user.email,
        "nombre": user.nombre,
        "password": password,
        "viviendaId": viviendaId
      }),
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){

      return User.fromJson(decodeJson);

    }else{
      return decodeJson["message"].toString();
    }
  }
}