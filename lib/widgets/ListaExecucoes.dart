import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praxis/modelos/Atividades.dart';
import 'package:praxis/modelos/Execucao.dart';
import 'package:praxis/servicos/webservice.dart';
import 'package:intl/intl.dart';
import 'package:praxis/utilidades/globals.dart' as globals;

class listaExecucoes extends StatefulWidget {

  Atividades atividadeCorrente;

  listaExecucoes(Atividades atividadeSelecionada, {Key key}) : super(key: key) {
    atividadeCorrente = atividadeSelecionada;
  }

  @override
  _Execucoes createState() => _Execucoes(atividadeCorrente);
}

class _Execucoes extends State<listaExecucoes> {

  double _inputHeight = 50;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(_checkInputHeight);
    _controller = new ScrollController();
    _controller.addListener(_scrollListener);
    carregaExecucoes();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _checkInputHeight() async {
    int count = _textEditingController.text
      .split('\n')
      .length;

    if (count == 0 && _inputHeight == 50.0) {
      return;
    }
    if (count <= 5) {
      // use a maximum height of 6 rows
      // height values can be adapted based on the font size
      var newHeight = count == 0 ? 50.0 : 28.0 + (count * 18.0);
      setState(() {
        _inputHeight = newHeight;
      });
    }
  }

  Atividades atividadeCorrente;
  List<Execucao> listaExecucoes = List<Execucao>();
  ScrollController _controller;

  _Execucoes(Atividade) {
    atividadeCorrente = Atividade;
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
      !_controller.position.outOfRange) {
      setState(() {});
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
      !_controller.position.outOfRange) {
      setState(() {});
    }
  }

  _moveDown() {
    _controller.animateTo(_controller.offset + listaExecucoes.length + 100,
      curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  void carregaExecucoes() {
    Map<String, String> params = {
      "pmo": "eq." + atividadeCorrente.id.toString(),
      "order": "id.asc"
    };

    Webservice().get(Execucao.all, params).then((itens) =>
    {
      setState(() => {listaExecucoes = itens}),
      _moveDown()
    });
  }

  void salvarComentario() {
    Map<String, String> params = {
      "pmo": atividadeCorrente.id.toString(),
      "firstuser": 'oberdan',
      "observacoes": _textEditingController.text
    };

    Webservice().post(Execucao.insert, params: params).then((itens) =>
    {
      setState(() =>
      {
        listaExecucoes.insert(listaExecucoes.length, itens),
        _moveDown()
      }),
    });
  }

  void finalizarTarefa() {
    Map<String, String> queryParameters = {
      "id": "eq." + atividadeCorrente.id.toString()
    };

    Map<String, String> params = {"situacao": "3"};

    Webservice()
      .patch(Execucao.update,
      queryParameters: queryParameters, params: params)
      .then((itemAtividade) =>
    {
      setState(() => {Navigator.pop(context)})
    });
  }

  Card _buildItemsForListView(BuildContext context, int index) {

    Execucao itemExecucao = listaExecucoes[index];

    var formatter = new DateFormat('dd/MM/yyyy H:m');
    String firstdade = formatter.format(itemExecucao.firstdate);


    Card comentario = Card(
      color: Colors.white,
      margin: new EdgeInsets.only(top: 5, bottom: 5, left: MediaQuery.of(context).size.width * 0.1),
      elevation: globals.APP_ELEVATION,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.title),
            title: Container(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(itemExecucao.observacoes),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(firstdade),
                SizedBox(
                  width: 5,
                ),
                Text(
                  itemExecucao.firstuser,
                  style: TextStyle(
                    color: Theme
                      .of(context)
                      .primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Card component = Card(
      color: Color(0xFFccff90),
      margin: new EdgeInsets.only(top: 5, bottom: 5, right: MediaQuery.of(context).size.width * 0.1),
      elevation: globals.APP_ELEVATION,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Container(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(listaExecucoes[index].observacoes),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(firstdade),
                SizedBox(
                  width: 5,
                ),
                Text(
                  listaExecucoes[index].firstuser,
                  style: TextStyle(
                    color: Theme
                      .of(context)
                      .primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );


    switch (itemExecucao.documentoTipo) {
      case 'comment':
        return comentario;
      case 'component':
        return component;

    }
  }



  @override
  Widget build(BuildContext context) {

    final GlobalKey _menuKey = new GlobalKey();

    final menuOperacoes = new PopupMenuButton(
      key: _menuKey,
      onSelected: (result) {
        switch (result) {
          case 'materiais':

            break;
          case 'encerrar':
            finalizarTarefa();
            break;
          case 'foto':
            break;
        }
      },
      child: Icon(Icons.more_vert),
      itemBuilder: (context) =>
      [
        PopupMenuItem(
          value: 'materiais',
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.format_list_numbered_rtl)),
              Text("Adicionar itens")
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
      ],
    );

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
                itemCount: listaExecucoes.length,
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
              color: Theme
                .of(context)
                .scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4)
              ]),
            width: MediaQuery
              .of(context)
              .size
              .width,
            child: Row(
              children: <Widget>[
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      Center(
                        child: menuOperacoes,
                      )
                    ],
                  ),
                ),
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
                    style: Theme
                      .of(context)
                      .textTheme
                      .body1,
                  )),
                IconButton(
                  icon: Icon(Icons.insert_comment),
                  color: Colors.black54,
                  onPressed: () {
                    salvarComentario();
                    _textEditingController.clear();
                  })
              ],
            )
          )
        ],
      )
    );
  }
}