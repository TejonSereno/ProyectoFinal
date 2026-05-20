
import 'package:flutter_application_1/data/model/usuario/usuario.dart';

class UsuarioList {
  List<Usuario> usuarios = [];

  UsuarioList({required this.usuarios});

  factory UsuarioList.fromJson(List<dynamic> json){
    return UsuarioList(usuarios: json.map((u) => Usuario.fromJson(u)).toList());
  }
}