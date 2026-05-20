import 'package:flutter_application_1/data/model/votacion/Votacion.dart';

class Votacionlist {
  List<Votacion> votaciones = [];

  Votacionlist({required this.votaciones});

  factory Votacionlist.fromJson(List<dynamic> json){
    return Votacionlist(votaciones: json.map((v) => Votacion.fromJson(v)).toList());
  }
}