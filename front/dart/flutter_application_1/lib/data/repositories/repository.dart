import 'dart:convert';

import 'package:flutter_application_1/data/model/aviso/aviso_list.dart';
import 'package:flutter_application_1/data/model/incidencia/incidencia_list.dart';
import 'package:flutter_application_1/data/model/user.dart';
import 'package:flutter_application_1/data/model/usuario/usuario_list.dart';
import 'package:flutter_application_1/data/model/vivienda/viviendaDetalle.dart';
import 'package:flutter_application_1/data/model/vivienda/vivienda_list.dart';
import 'package:flutter_application_1/data/model/votacion/votacion_list.dart';
import 'package:flutter_application_1/data/model/votacion/votacion_detalle.dart';
import 'package:flutter_application_1/data/model/voto/voto.dart';
import 'package:http/http.dart' as http;

class Repository {
  final String url = "http://192.168.1.153:8080/api";

  Future getlogin(String email, String password) async{
    final response = await http.post(
      Uri.parse("$url/usuarios/login"),
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

      return User.fromJson(decodeJson);

    }else{
      return decodeJson["message"].toString();
    }
  }

  Future getRegistre(User user, String password, int viviendaId) async{
    final response = await http.post(
      Uri.parse("$url/usuarios/registre"),
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

  Future getViviendas() async{
    final response = await http.get(
      Uri.parse("$url/viviendas/listado"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return ViviendaList.fromJson(decodeJson);
    }else{
      return decodeJson["message"].toString();
    }
  }

  Future putNewVivienda(String calle, String numero) async{
    final response = await http.post(
      Uri.parse("$url/api/viviendas"),
      headers: {
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

  Future deleteVivienda(int viviendaId) async{
    final response = await http.delete(
      Uri.parse("$url/viviendas/$viviendaId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future getUsuarios() async{
    final response = await http.get(
      Uri.parse("$url/usuarios/listado"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return UsuarioList.fromJson(decodeJson);
    }else{
      return decodeJson["message"].toString();
    }
  }

  Future deleteUsuario(int usuarioId) async{
    final response = await http.delete(
      Uri.parse("$url/usuarios/$usuarioId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future changeRole(int usuarioId) async{
    final response = await http.post(
      Uri.parse("$url/usuarios/$usuarioId/rol"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future createIncidencia(String titulo, String descripcion, String estado, int usuarioId) async{
    final response = await http.post(
      Uri.parse("$url/incidencias"),
      headers: {
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

  Future getActiveIncidencias() async{
    final response = await http.get(
      Uri.parse("$url/incidencias/recientes"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return Incidencialist.fromJson(decodeJson);
    }else{
      return decodeJson["message"].toString();
    }
  }

  Future changeState(int incidenciaId) async{
    final response = await http.post(
      Uri.parse("$url/incidencias/$incidenciaId/estado"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future deleteIncidencia(int incidenciaId) async{
    final response = await http.delete(
      Uri.parse("$url/incidencias/$incidenciaId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future createVotacion(String titulo, String descripcion, DateTime fechaFin, List<String> opciones) async{
    final response = await http.post(
      Uri.parse("$url/votaciones"),
      headers: {
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

  Future getActiveVotaciones() async{
    final response = await http.get(
      Uri.parse("$url/votaciones/recientes"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return Votacionlist.fromJson(decodeJson);
    }else{
      return decodeJson["message"].toString();
    }
  }

  Future getVotacion(int votacionId) async{
    final response = await http.get(
      Uri.parse("$url/votaciones/$votacionId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return VotacionDetalle.fromJson(decodeJson);
    }else{
      return decodeJson["message"].toString();
    }
  }

  Future deleteVotacion(int votacionId) async{
    final response = await http.delete(
      Uri.parse("$url/votaciones/$votacionId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future getVotacionDetalle(int votacionId) async{
    final response = await http.get(
      Uri.parse("$url/votaciones/$votacionId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return VotacionDetalle.fromJson(decodeJson);
    }else{
      return decodeJson["message"].toString();
    }
  }

  Future getVoto(int userId, int votacionId) async{
    final response = await http.get(
      Uri.parse("$url/votos/$userId/$votacionId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return Voto.fromJson(decodeJson);
    }else{
      return decodeJson["message"].toString();
    }
  }

  Future votar(int userId, int votacionId, String opcion) async{
    final response = await http.post(
      Uri.parse("$url/votos"),
      headers: {
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
      return decodeJson["message"].toString();
    }
  }

  Future getViviendaDetalle(int id) async{
    final response = await http.get(
      Uri.parse("$url/viviendas/$id"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return ViviendaDetalle.fromJson(decodeJson);
    }else{
      return decodeJson["message"].toString();
    }
  }

  Future getAvisosActivos() async{
    final response = await http.get(
      Uri.parse("$url/avisos/activos"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var decodeJson = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      return AvisoList.fromJson(decodeJson);
    }else{
      return decodeJson["message"].toString();
    }
  }

  Future createAviso(String titulo, String descripcion, DateTime fechaFin) async{
    final response = await http.post(
      Uri.parse("$url/avisos"),
      headers: {
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

  Future deleteAviso(int avisoId) async{
    final response = await http.delete(
      Uri.parse("$url/avisos/$avisoId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return response.statusCode;
  }

  Future updateUsuario(int id, String nombre,String email, String password) async{
    final response = await http.put(
      Uri.parse("$url/usuarios/$id"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "nombre": nombre,
        "email": email,
        "password": password
      })
    );

    return response.statusCode;
  }
}