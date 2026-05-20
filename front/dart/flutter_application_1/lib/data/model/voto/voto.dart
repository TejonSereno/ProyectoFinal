class Voto {
  final int id;
  final String opcion;
  final int votacionId;

  Voto(this.id, this.opcion, this.votacionId);

  factory Voto.fromJson(Map<String, dynamic> json) => Voto(json['id'], json['opcion'].toString().trim(), json['votacionId']);
}