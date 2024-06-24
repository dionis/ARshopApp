class Entidad {
  int id;
  String logo;

  String nombre;
  String direccion;
  String telefono;
  String descripcion;
  String paginaOficial;

  Entidad(
    this.id,
    this.nombre,
    this.direccion,
    this.descripcion,
    this.paginaOficial,
    this.telefono,
    this.logo,
  );

  factory Entidad.fromJson(Map<String, dynamic> json) {
    return Entidad(
      json['id'],
      json['nombre'],
      json['direccion'],
      json['descripcion'],
      json['paginaOficial'],
      json['telefono'],
      json['logo'],
    );
  }
}
