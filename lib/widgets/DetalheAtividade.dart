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

  double _inputHeight = 50;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(_checkInputHeight);
    _controller = new ScrollController();
    _controller.addListener(_scrollListener);
    carregaAtividades();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _checkInputHeight() async {
    int count = _textEditingController.text.split('\n').length;

    if (count == 0 && _inputHeight == 50.0) {
      return;
    }
    if (count <= 5) {  // use a maximum height of 6 rows
      // height values can be adapted based on the font size
      var newHeight = count == 0 ? 50.0 : 28.0 + (count * 18.0);
      setState(() {
        _inputHeight = newHeight;
      });
    }
  }

  Solicitacoes ItemSolicitacao;
  List<Atividades> listadeAtividades = List<Atividades>();
  ScrollController _controller;

  _Atividades(Solicitacao) {
    ItemSolicitacao = Solicitacao;
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {

      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {

      });
    }
  }

  _moveDown() {
    _controller.animateTo(_controller.offset + listadeAtividades.length + 100,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  void carregaAtividades() {
    Map<String, String> params = {
      "pmo": "eq." + ItemSolicitacao.id.toString(),
      "order": "id.asc"
    };

    Webservice().get(Atividades.all, params).then((itemAtividade) => {
          setState(() => {listadeAtividades = itemAtividade}),
            _moveDown()
        });
  }

  void salvarComentario() {
    Map<String, String> params = {
      "pmo": ItemSolicitacao.id.toString(),
      "firstuser": 'oberdan',
      "observacoes": _textEditingController.text
    };

    Webservice()
        .post(Atividades.insert, params: params)
        .then((itemAtividade) => {
              setState(() => {
                    listadeAtividades.insert(
                        listadeAtividades.length, itemAtividade),
                    _moveDown()
                  }),
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
      margin: new EdgeInsets.only(top: 1.0),
      elevation: 1,
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

  /*
  *
  *

  * */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _controller,
                  reverse: false,
                  itemCount: listadeAtividades.length,
                  itemBuilder: _buildItemsForListView,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                //height: 56,
                padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 4)
                    ]),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    new Flexible(
                        child: new TextField(
                      controller: _textEditingController,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.call_to_action),
                          hintText: 'Detalhes do atendimento'),
                      style: Theme.of(context).textTheme.body1,
                    )),
                    IconButton(
                        icon: Icon(Icons.insert_comment),
                        color: Colors.black54,
                        onPressed: () {
                          salvarComentario();
                          _textEditingController.clear();
                        })
                  ],
                ))
          ],
        ));
  }
}
