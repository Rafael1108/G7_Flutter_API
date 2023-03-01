import 'package:flutter/material.dart';
import 'package:g7_taller_api/api.dart';
import 'package:g7_taller_api/model/Instituciones.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Grupo 7 Consumo API',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: const HomePage(title: 'Grupo 7 Consumo API'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Instituciones>>? _listInstitucion;
  @override
  void initState() {
    super.initState();
    _listInstitucion = _getData();
  }

  Future<List<Instituciones>> _getData() async {
    return (await Api().GetInstituciones());
    // Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _listInstitucion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 1,
              children: _lstWidgetInstitucion(snapshot.data),
              padding: const EdgeInsets.all(10),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

List<Widget> _lstWidgetInstitucion(data) {
  List<Widget> _Instituciones = [];
  for (var institucion in data) {
    _Instituciones.add(
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              //leading: Icon(Icons.arrow_drop_down_circle),
              title: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Center(
                      child: Text(institucion.Siglas.toString().trim(),
                          style:
                              TextStyle(fontSize: 20, color: Colors.indigo)))),
              subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Center(
                      child: Text(institucion.Nombre.toString().trim(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.8))))),
            ),
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: FadeInImage(
                  image: NetworkImage(
                    institucion.Logo,
                  ),
                  placeholder: AssetImage("assets/img/gobierno.png"),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/img/gobierno.png',
                        fit: BoxFit.scaleDown);
                  },
                  fit: BoxFit.fill,
                  height: 80,
                  //  width: MediaQuery.of(context).size.width,
                )),
            Padding(
                padding: const EdgeInsets.all(3),
                child: ListTile(
                  title: Column(
                    children: [
                      InputChip(
                        disabledColor: Colors.yellow,
                        isEnabled: true,
                        labelStyle: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(1)),
                        label: Text(institucion.Sector,
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    extraeDetalle(institucion.Descripcion.toString().trim()),
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                )),
            TextButton(
              onPressed: () => _launchUrl(institucion.Url),
              child: Text("SITIO WEB"),
            ),
          ],
        ),
      ),

      //
      //
      //
      //
      //
      //
      // Card(
      //   child: ListTile(
      //       title:
      //           Text(institucion.Nombre, style: TextStyle(color: Colors.white))),
      // Column(
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         Text(institucion.Id.toString()),
      //         Text(institucion.Nombre),
      //         // Expanded(child: Image.network(institucion.Logo, fit: BoxFit.fill)),
      //         Text(institucion.Url),
      //       ],
      //     ),
      //     const SizedBox(
      //       height: 20.0,
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         Text(institucion.Nombre),
      //         Text(institucion.Url),
      //       ],
      //     ),
      //   ],
      // )
      // )
    );
  }
  return _Instituciones;
}

String extraeDetalle(str) {
  int maxlengt = 200;
  if (str.toString().length > maxlengt)
    return str.toString().substring(0, maxlengt) + "...";
  else
    return str;
}

Future<void> _launchUrl(_url) async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
