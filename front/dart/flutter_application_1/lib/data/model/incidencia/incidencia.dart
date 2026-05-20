class Incidencia {
  final int id;
  final String titulo;
  final String descripcion;
  final String estado;

  Incidencia({required this.id, required this.titulo, required this.descripcion, required this.estado});

  factory Incidencia.fromJson(Map<String, dynamic> json){
    return Incidencia(id: json['id'], titulo: json['titulo'], descripcion: json['descripcion'], estado: json['estado']);
  }
}