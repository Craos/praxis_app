import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praxis/modelos/Atividades.dart';
import 'package:praxis/modelos/Solicitacoes.dart';
import 'package:praxis/servicos/webservice.dart';

import 'ComentarAtividade.dart';

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
      margin: new EdgeInsets.all(3),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.text_rotation_angledown),
            title: Container(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(listadeAtividades[index].observacoes),
            ),
            subtitle: Row(
              children: <Widget>[
                Text(
                    listadeAtividades[index].firstdate.toString()
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                    listadeAtividades[index].firstuser,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_vert),
                  color: Theme.of(context).disabledColor,
                  onPressed: () => null,
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
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: listadeAtividades.length,
            itemBuilder: _buildItemsForListView,
          ),
          Positioned(
            bottom: 0,
            child: ComentarAtividade()
          )

        ],
      ),

    );
  }
}
