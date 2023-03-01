import 'dart:convert';

class Instituciones {
  final String Id;
  final String Nombre;
  final String Siglas;
  final String Logo;
  final String Url;
  final String Website;
  final String Tipo;
  final String Descripcion;
  final String Sector;

  Instituciones(this.Id, this.Nombre, this.Siglas, this.Logo, this.Url,
      this.Website, this.Tipo, this.Descripcion, this.Sector);

  // factory Instituciones.fromMap(Map<String, dynamic> json) {
  //   return Instituciones(
  //       json['institucion_id'],
  //       json['institucion'],
  //       json['siglas'],
  //       json['logo'],
  //       json['url'],
  //       json['website'],
  //       json['tipo'],
  //       json['descripcion'],
  //       json['sector']);
  // }

  factory Instituciones.fromJson(Map<String, dynamic> data) {
    return Instituciones(
        data['institucion_id'],
        data['institucion'],
        data['siglas'],
        data['logo'],
        data['url'],
        data['website'],
        data['tipo'],
        data['descripcion'],
        data['sector']);
  }

  static List<Instituciones> parseInstituciones(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Instituciones>((json) => Instituciones.fromJson(json))
        .toList();
  }
}
