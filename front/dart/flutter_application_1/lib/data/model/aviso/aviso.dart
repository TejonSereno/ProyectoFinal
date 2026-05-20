class Aviso {
  final int id;
  final String titulo;
  final String descripcion;
  final DateTime fechaFin;

  Aviso(this.id, this.titulo, this.descripcion, this.fechaFin);

  factory Aviso.fromJson(Map<String, dynamic> json) {
    return Aviso(json['id'], json['titulo'], json['descripcion'], DateTime.parse(json['fechaFin']));
  }
}