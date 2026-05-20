
class Vivienda {
  final int id;
  final String calle;
  final String numero;
  final int nUsuarios;

  Vivienda({required this.id, required this.calle, required this.numero, required this.nUsuarios});
  
  factory Vivienda.fromJson(Map<String, dynamic> json){

    return Vivienda(id: json["id"].toInt(), calle: json["calle"], numero: json["numero"], nUsuarios: json["nUsuarios"] ?? 0);
  }
}