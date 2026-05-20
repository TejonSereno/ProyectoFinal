import 'package:flutter_application_1/data/model/vivienda/vivienda.dart';

class ViviendaList {
  List<Vivienda> viviendas = [];

  ViviendaList({required this.viviendas});

  factory ViviendaList.fromJson(List<dynamic> json){
    return ViviendaList(viviendas: json.map((v) => Vivienda.fromJson(v)).toList());
  }
}