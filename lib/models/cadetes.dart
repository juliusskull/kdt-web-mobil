class Cadetes{
  final  int id;
  final String descripcion;
  final  int idComercio;

  Cadetes({this.id, this.descripcion, this.idComercio});

  factory Cadetes.fromJson(Map<String, dynamic> json) {
    return Cadetes(
      id: json['id'],
      descripcion: json['usuario'],
      idComercio: json['id_comercio'],
    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["usuario"] = descripcion;
    map["id_comercio"] = idComercio;

    return map;
  }
}