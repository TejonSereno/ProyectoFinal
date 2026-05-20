import 'package:flutter_application_1/data/model/vivienda/vivienda.dart';

class User {
  int id;
  String email;
  String nombre;
  String password;
  String rol;
  Vivienda? vivienda;

  User({required this.id, required this.email, required this.nombre, required this.password, required this.rol, this.vivienda});

  User copyWith({
    int? id,
    String? nombre,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      password: password ?? this.password,
      rol: rol,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    if(json["viviendaDTO"] != null){
      return User(id: json["id"].toInt(), email: json["email"], nombre: json["nombre"], password: json["password"], rol: json["rol"],
          vivienda: Vivienda.fromJson(json["viviendaDTO"]));

    }else{
      return User(id: json["id"].toInt(), email: json["email"], nombre: json["nombre"], password: json["password"], rol: json["rol"]);
    }
  }
}