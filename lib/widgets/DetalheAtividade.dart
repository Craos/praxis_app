import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praxis/modelos/Atividades.dart';
import 'package:praxis/modelos/Solicitacoes.dart';
import 'package:praxis/servicos/webservice.dart';
import 'package:intl/intl.dart';

class detalheSolicitacao extends StatefulWidget {
  Solicitacoes Solicitacao;

  detalheSolicitacao(Solicitacoes itemSolicitacao, {Key key})
      : super(key: key) {
    Solicitacao = itemSolicitacao;
  }

  @override
  _Atividades createState() => _Atividades(Solicitacao);
}

class _Atividades extends State<detalheSolicitacao> {
  final ComentarioController = TextEditingController();

  Solicitacoes ItemSolicitacao;
  List<Atividades> listadeAtividades = List<Atividades>();
  ScrollController _scrollController = new ScrollController();

  _Atividades(Solicitacao) {
    ItemSolicitacao = Solicitacao;
  }

  @override
  void initState() {
    super.initState();
    carregaAtividades();
  }

  void carregaAtividades() {
    Map<String, String> params = {
      "pmo": "eq." + ItemSolicitacao.id.toString(),
      "order":"id.asc"
    };

    Webservice().get(Atividades.all, params).then((itemAtividade) => {
          setState(() => {listadeAtividades = itemAtividade}),
          _scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          )
        });
  }

  void salvarComentario() {
    Map<String, String> params = {
      "pmo": ItemSolicitacao.id.toString(),
      "firstuser": 'oberdan',
      "observacoes": ComentarioController.text
    };

    Webservice()
        .post(Atividades.insert, params: params)
        .then((itemAtividade) => {
              setState(() => {
                    listadeAtividades.insert(
                        listadeAtividades.length, itemAtividade)
                  }),
              _scrollController.animateTo(
                0.0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              )
            });
  }

  void finalizarTarefa() {
    Map<String, String> queryParameters = {
      "id": "eq." + ItemSolicitacao.id.toString()
    };

    Map<String, String> params = {"situacao": "3"};

    Webservice()
        .patch(Solicitacoes.update,
            queryParameters: queryParameters, params: params)
        .then((itemAtividade) => {
              setState(() => {Navigator.pop(context)})
            });
  }

  void obterFoto() {
    return null;
  }

  Card _buildItemsForListView(BuildContext context, int index) {
    var formatter = new DateFormat('dd/MM/yyyy H:m');
    String firstdade = formatter.format(listadeAtividades[index].firstdate);

    return Card(
      color: Colors.white,
      margin: new EdgeInsets.only(top: 2.0),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.title),
            title: Container(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(listadeAtividades[index].observacoes),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(firstdade),
                SizedBox(
                  width: 5,
                ),
                Text(
                  listadeAtividades[index].firstuser,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      Center(
                        child: PopupMenuButton(
                          onSelected: (result) {
                            switch (result) {
                              case 'encerrar':
                                finalizarTarefa();
                                break;
                              case 'foto':
                                obterFoto();
                                break;
                            }
                          },
                          child: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'encerrar',
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(Icons.flag)),
                                  Text("Encerrar atividades")
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'foto',
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(Icons.add_a_photo)),
                                  Text("Obter foto")
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
      appBar: new AppBar(),
      body: Stack(
        children: <Widget>[


              ListView.builder(
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                shrinkWrap: true,
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
                              salvarComentario();
                              ComentarioController.clear();
                            }),
                      ],
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
