
import 'package:flutter_application_1/data/model/usuario/usuario.dart';

class ViviendaDetalle {
  int id;
  String calle;
  String numero;
  List<Usuario> usuarios;

  ViviendaDetalle({required this.id, required this.calle, required this.numero, required this.usuarios});

  factory ViviendaDetalle.fromJson(Map<String, dynamic> json) {
    return ViviendaDetalle(
      id: json['id'],
      calle: json['calle'],
      numero: json['numero'],
      usuarios: (json['usuarios'] as List).isNotEmpty 
        ? (json['usuarios'] as List).map((u) => Usuario.fromJson(u)).toList() : [],
    );
  }
}