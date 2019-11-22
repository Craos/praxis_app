import 'package:flutter/material.dart';
import 'package:praxis/modelos/Atividades.dart';
import 'package:praxis/servicos/webservice.dart';
import 'package:praxis/utilidades/globals.dart' as globals;
import 'package:praxis/widgets/Apresentacao.dart';
import 'package:praxis/widgets/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'servicos/database_helpers.dart';

void main() => runApp(PraxisApp());

class PraxisApp extends StatelessWidget {

  bool first = true;
  List<Atividades> registrosNovasAtividades = List<Atividades>();

  PraxisApp() {
    carregaServicosIniciais();
  }

  carregaServicosIniciais() async {

    _verificaPrimeiroAcesso();
    _primeiroBuscaNovosIDs();

  }

  _verificaPrimeiroAcesso() async {

    final prefs = await SharedPreferences.getInstance();
    first = prefs.containsKey('primeiroacesso');

  }

  _primeiroBuscaNovosIDs() async {

    DatabaseHelper helper = DatabaseHelper.instance;
    helper.MaxId(Atividades.localdbLastId).then((id)  {

      if (id != null) {
        var params = {
          "id": "gt." + id.toString(),
          "order": "id.asc"
        };

        Webservice().get(Atividades.all, params).then((registros) => {
          _salvaNovasAtividades(registros)
        });
      } else {
        Webservice().get(Atividades.all).then((registros) => {
          _salvaNovasAtividades(registros)
        });
      }

    });

  }

  _salvaNovasAtividades(List<Atividades> registros) async {

    DatabaseHelper helper = DatabaseHelper.instance;

    registros.forEach((item) async {
      int id = await helper.insert(Atividades.localdbInsert, item.toMap());
      print('insert do registro $id');
    });

  }

  @override
  Widget build(BuildContext context) {
    ThemeData temadoPraxis = ThemeData(
        backgroundColor: Color(0xfff4f6fb),
        primaryColor: Colors.indigo,
        secondaryHeaderColor: Colors.purple,
        toggleableActiveColor: Colors.deepPurple,
        errorColor: Colors.deepOrange,
        textTheme: new TextTheme(
            subtitle : new TextStyle(color: Color(0xff38006b)),
            body1: new TextStyle(color: Colors.black45, fontSize: 14),
            title: new TextStyle(color: Colors.indigo, fontSize: 16)
        )
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: globals.APP_NAME,
      theme: temadoPraxis,
      home: (first) ? Home(title: globals.APP_NAME) : CarouselPage(),
    );
  }


}
