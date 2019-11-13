import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praxis/modelos/Atividades.dart';
import 'package:praxis/modelos/Solicitacoes.dart';
import 'ResponderAtividade.dart';
import 'package:praxis/servicos/webservice.dart';

class DetalheSolicitacao extends StatefulWidget {
  DetalheSolicitacao(Solicitacoes listadeSolicitaco, {Key key}) : super(key: key);

  @override
  _Atividades createState() => _Atividades();
}

class _Atividades extends State<DetalheSolicitacao> {

  List<Atividades> listadeAtividades = List<Atividades>();

  @override
  void initState() {
    super.initState();
    CarregaAtividades();
  }

  void CarregaAtividades() {

    Webservice().load(Atividades.all).then((itemAtividade) => {
      setState(() => {
        listadeAtividades = itemAtividade
      })
    });

  }

  Card _buildItemsForListView(BuildContext context, int index) {

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
            leading: Icon(Icons.text_rotation_angledown),
            title: Text(listadeAtividades[index].firstdate.toString()),
            subtitle: Text(listadeAtividades[index].observacoes),
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('EXCLUIR'),
                  onPressed: () {

                  },
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
        itemCount: listadeAtividades.length,
        itemBuilder: _buildItemsForListView,
      ),

    );
  }
}
