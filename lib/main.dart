import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:praxis/widgets/BottomNavBar.dart';
import 'package:praxis/utilidades/constants.dart';

import 'package:praxis/modelos/Solicitacoes.dart';
import 'package:praxis/servicos/webservice.dart';
import 'package:praxis/widgets/DetalheAtividade.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Práxis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: Constants.APP_NAME),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _app createState() => _app();
}

class _app extends State<Home> {

  List<Solicitacoes> listadeSolicitacoes = List<Solicitacoes>();

  @override
  void initState() {
    super.initState();
    CarregaAtividades();
  }

  void CarregaAtividades() {

    Webservice().load(Solicitacoes.all).then((itemSolicitado) => {
      setState(() => {
        listadeSolicitacoes = itemSolicitado
      })
    });

  }

  Card _buildItemsForListView(BuildContext context, int index) {

    Color getColor(String selector) {
      switch(selector) {
        case '1':
          return Colors.lightGreen;
          break;
        case '2':
          return Colors.blue;
          break;
        case '3':
          return Colors.deepOrange;
          break;
        case '4':
          return Colors.grey;
          break;
        default:
      }

    }

    return Card(
        color: Colors.white,
        margin: new EdgeInsets.all(10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                  Icons.assignment_turned_in,
                  color: getColor(listadeSolicitacoes[index].situacao.toString())
              ),
              title: Text(listadeSolicitacoes[index].titulo),
              subtitle: Text(listadeSolicitacoes[index].descricao),
            ),
            ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('ATENDER'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => DetalheSolicitacao(listadeSolicitacoes[index])
                          ));
                    },
                  ),
                  FlatButton(
                    child: const Text('CONCLUIR'),
                    onPressed: () { /* ... */ },
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(

      ),
      body: ListView.builder(
        itemCount: listadeSolicitacoes.length,
        itemBuilder: _buildItemsForListView,
      ),
      bottomNavigationBar: BottomNavyBar(),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blueAccent.withAlpha(80),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: AppBar(
              title: new Container(
                child: TextField(
                  decoration: new InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: "Pesquisar"
                  ),
                ),
                decoration: new BoxDecoration (
                    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  color: Colors.white.withAlpha(180),
                ),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white.withAlpha(180),
                  onPressed: () => null,
                ),
              ],
            ) ,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}