import 'package:flutter_application_1/data/model/aviso/aviso.dart';

class AvisoList {
  List<Aviso> avisos = [];

  AvisoList({required this.avisos});

  factory AvisoList.fromJson(List<dynamic> json) {
    return AvisoList(avisos: json.map((a) => Aviso.fromJson(a)).toList());
  }
}