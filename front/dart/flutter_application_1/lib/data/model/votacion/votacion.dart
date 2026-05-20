
class Votacion {
  final int id;
  final String titulo;
  final String descripcion;
  final DateTime fechaFin;
  final int nVotos;

  Votacion({required this.id, required this.titulo, required this.descripcion, required this.fechaFin, required this.nVotos});

  factory Votacion.fromJson(Map<String, dynamic> json){
    
    return Votacion(id: json['id'], titulo: json['titulo'], descripcion: json['descripcion'], fechaFin: DateTime.parse(json['fechaFin']), nVotos: json['totalVotos']);
  }
}