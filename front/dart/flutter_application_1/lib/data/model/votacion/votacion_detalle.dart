
class VotacionDetalle {
  int id;
  String titulo;
  String descripcion;
  DateTime fechaFin;
  Map<String, int> votos;

  
  VotacionDetalle(this.id, this.titulo, this.descripcion, this.fechaFin, this.votos);

  factory VotacionDetalle.fromJson(Map<String, dynamic> json){
    return VotacionDetalle(json['id'], json['titulo'], json['descripcion'], DateTime.parse(json['fechaFin']), Map<String, int>.from(json['resultados']));
  }
}