class Productos {
  final  int id;
  final  int idNegocio;
  final String descripcion;
  final String precio;
  final String foto;
  final String fchalta;
  Productos( {this.id,this.idNegocio,this.descripcion,this.precio,this.foto,this.fchalta});

  factory Productos.fromJson(Map<String, dynamic> json) {
    return Productos(
      id: json['id'],
      idNegocio: json['id_negocio'],
      descripcion: json['descripcion'],
      precio: json['precio'],
      foto: json['foto'],
      fchalta: json['fchalta'],

    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["id_negocio"] = idNegocio;
    map["descripcion"] = descripcion;
    map["precio"] = precio;
    map["foto"] = foto;
    map["fchalta"] = fchalta;

    return map;
  }
}