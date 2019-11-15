import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praxis/modelos/Atividades.dart';
import 'package:praxis/modelos/Solicitacoes.dart';
import 'package:praxis/servicos/webservice.dart';

//import 'ComentarAtividade.dart';

class DetalheSolicitacao extends StatefulWidget {
  var Solicitaco;

  DetalheSolicitacao(Solicitacoes listadeSolicitaco, {Key key})
      : super(key: key) {
    Solicitaco = listadeSolicitaco.id;
  }

  @override
  _Atividades createState() => _Atividades(Solicitaco);
}

class _Atividades extends State<DetalheSolicitacao> {
  final ComentarioController = TextEditingController();

  var IdTarefa;
  List<Atividades> listadeAtividades = List<Atividades>();

  _Atividades(id) {
    IdTarefa = id;
  }

  @override
  void initState() {
    super.initState();
    CarregaAtividades();
  }

  void CarregaAtividades() {
    Map<String, String> params = {"pmo": "eq." + IdTarefa.toString()};

    Webservice().load(Atividades.all, params).then((itemAtividade) => {
          setState(() => {listadeAtividades = itemAtividade})
        });
  }

  void SalvarComentario() {
    Map<String, String> params = {
      "pmo": IdTarefa.toString(),
      "firstuser": 'oberdan',
      "observacoes": ComentarioController.text
    };

    Webservice().send(Atividades.save, params: params).then((itemAtividade) => {
          setState(() => {
                listadeAtividades.insert(
                    listadeAtividades.length, itemAtividade)
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
                Text(listadeAtividades[index].firstdate.toString()),
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
          ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                Center(
                  child: PopupMenuButton(
                    child: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("InduceSmile.com"),
                      ),
                      PopupMenuItem(
                        child: Text("Flutter.io"),
                      ),
                      PopupMenuItem(
                        child: Text("Google.com"),
                      ),
                    ],
                  ),
                )
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
      appBar: new AppBar(),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: listadeAtividades.length,
            itemBuilder: _buildItemsForListView,
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  height: 56,
                  padding:
                      EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ]),
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        new Flexible(
                          child: new TextField(
                            controller: ComentarioController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.call_to_action),
                                hintText: 'Detalhes do atendimento'),
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.insert_comment),
                            color: Colors.black54,
                            onPressed: () {
                              SalvarComentario();
                              ComentarioController.clear();
                            }),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
