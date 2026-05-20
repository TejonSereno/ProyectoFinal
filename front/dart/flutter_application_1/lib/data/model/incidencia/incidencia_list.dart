import 'package:flutter_application_1/data/model/incidencia/incidencia.dart';

class Incidencialist {
  List<Incidencia> incidencias = [];

  Incidencialist({required this.incidencias});

  factory Incidencialist.fromJson(List<dynamic> json) {
    return Incidencialist(incidencias: json.map((i) => Incidencia.fromJson(i)).toList());
  }

}