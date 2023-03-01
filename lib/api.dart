import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:g7_taller_api/model/Instituciones.dart';

class Api {
  static String URL = 'https://www.gob.ec/api/v1/';
  static String INSTITUCIONES_RUTA = 'instituciones';

  Future<List<Instituciones>> GetInstituciones() async {
    final response = await http.get(URL + INSTITUCIONES_RUTA);
    if (response.statusCode == 200) {
      return Instituciones.parseInstituciones(response.body);
    } else {
      throw Exception('Unable to fetch instituciones from the REST API');
    }
  }
}
