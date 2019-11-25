import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:praxis/modelos/Atividades.dart';
import 'package:praxis/servicos/database_helpers.dart';
import 'package:praxis/servicos/webservice.dart';
import 'package:praxis/widgets/BottomNavBar.dart';
import 'package:praxis/utilidades/globals.dart' as globals;
import 'package:praxis/widgets/ListaExecucoes.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _app createState() => _app();
}

class _app extends State<Home> {

  double _inputHeight = 50;
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Atividades _novaAtividade = new Atividades();

  List<Atividades> listaAtividades = List<Atividades>();
  ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = new ScrollController();
    _controller.addListener(_scrollListener);
    _textEditingController.addListener(_checkInputHeight);

    carregaAtividades();

  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
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
    if (_controller != null) {
      _controller.animateTo(_controller.offset + listaAtividades.length + 100,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
    }
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

  void adicionarNovasAtividades(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _novaAtividade.firstuser = 'oberdan';
      _novaAtividade.responsavel = 'oberdan';
      _novaAtividade.situacao = 4;
      _novaAtividade.progresso = 0;

      Webservice().post(Atividades.insert, params: _novaAtividade.toMap()).then((itens) =>
      {
        setState(() =>
        {
          listaAtividades.insert(listaAtividades.length, itens),
          _moveDown(),
          Navigator.of(context).pop()
        }),
      });
    }
  }

  void carregaAtividades() {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.selectAll(Atividades.localdbSelect).then((registros) =>
    {
      setState(() => {listaAtividades = registros})
    });
  }

  GestureDetector _construirListadeAtividades(BuildContext context, int index) {
    Color corIcone;
    Color corIconeBg;

    var formatter = new DateFormat('dd/MM/yyyy H:m');
    String firstdade = formatter.format(listaAtividades[index].firstdate);

    switch (listaAtividades[index].situacao.toString()) {
      case '1':
        corIcone = Color(0xFF90a4ae);
        corIconeBg = Color(0xFFeceff1);
        break;
      case '2':
        corIcone = Color(0xFF64b5f6);
        corIconeBg = Color(0xFFe3f2fd);
        break;
      case '3':
        corIcone = Color(0xFFe57373);
        corIconeBg = Color(0xFFffebee);
        break;
      case '4':
        corIcone = Color(0xFF32cb00);
        corIconeBg = Color(0xFFccff90);
        break;
      default:
    }

    return GestureDetector(
      child: Card(
        color: Colors.white,
        margin: new EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 3),
        elevation: globals.APP_ELEVATION,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(
            new Radius.circular(globals.APP_BORDER_RADIUS)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: new Container(
                width: 50,
                height: 50,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: corIconeBg,
                ),
                child: Center(
                  child: Icon(
                    Icons.assignment_turned_in,
                    color: corIcone,
                  )),
              ),
              title: DefaultTextStyle.merge(
                style: TextStyle(
                  color: Theme
                    .of(context)
                    .primaryColor,
                ),
                child: Text(
                  listaAtividades[index].titulo,
                  style: Theme
                    .of(context)
                    .textTheme
                    .title,
                )),
              subtitle: Text(listaAtividades[index].descricao,
                style: Theme
                  .of(context)
                  .textTheme
                  .body1),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      color: Theme
                        .of(context)
                        .toggleableActiveColor,
                    ),
                    child:
                    Text(listaAtividades[index].id.toString())),
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      color: Theme
                        .of(context)
                        .toggleableActiveColor,
                    ),
                    child: Text(listaAtividades[index].firstuser)),
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      color: Theme
                        .of(context)
                        .toggleableActiveColor,
                    ),
                    child: Text(firstdade)
                  ),
                ],
              ),
            ),
          ],
        )),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
              listaExecucoes(listaAtividades[index])));
      });
  }

  void _construirFormNovaAtividade(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            IconButton(
              icon: IconTheme(
                data: IconThemeData(size: 24, color: Colors.blue),
                child: Padding(
                  child: Icon(Icons.playlist_add_check),
                  padding: EdgeInsets.all(10),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  adicionarNovasAtividades(context);
                }
              },
            )
            ,
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(globals.APP_BORDER_RADIUS)
            )
          ),
          title: Row(
            children: <Widget>[
              Icon(
                Icons.playlist_add,
                color: Theme
                  .of(context)
                  .primaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Nova atividade")
            ],
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por favor informe um título';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _novaAtividade.titulo = value;
                    },
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      icon: Icon(Icons.flag),
                      hintText: 'Título'),
                    style: Theme
                      .of(context)
                      .textTheme
                      .body1,

                  ),
                ),
                new Flexible(
                  child: new TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Descreva os detalhes desta atividade';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _novaAtividade.descricao = value;
                    },
                    controller: _textEditingController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Detalhes desta atividade'),
                    style: Theme
                      .of(context)
                      .textTheme
                      .body1,
                  )),
              ])));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _construirFormNovaAtividade(context);
          }
        ),
      ]),
      body: ListView.builder(
        itemCount: listaAtividades.length,
        controller: _controller,
        itemBuilder: _construirListadeAtividades,
      ),
      bottomNavigationBar: BottomNavyBar(),
    );
  }
}
