class Usuario {
  int id;
  String email;
  String nombre;
  String rol;
  String? calle;
  String? numero;

  Usuario({required this.id, required this.email, required this.nombre, required this.rol, this.calle, this.numero});

  factory Usuario.fromJson(Map<String, dynamic> json){
    if(json["calle"] != null){
      return Usuario(id: json["id"], email: json["email"], nombre: json["nombre"], rol: json["rol"],
        calle: json["calle"], numero: json["numero"]);

    }else{
      return Usuario(id: json["id"], email: json["email"], nombre: json["nombre"], rol: json["rol"]);

    }
  }
}