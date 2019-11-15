import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:praxis/modelos/Atividades.dart';
import 'package:praxis/servicos/webservice.dart';

class ComentarAtividade extends StatefulWidget{

  StreamController changeController = StreamController<ComentarAtividadeState>();

  var pmo;

  ComentarAtividade(idTarefa) {
    pmo = idTarefa;
  }


  @override
  State<StatefulWidget> createState() {
    return ComentarAtividadeState(pmo);
    //return ComentarAtividadeState();
  }

}

class ComentarAtividadeState extends State<ComentarAtividade> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }


  Color backgroundColor = Colors.white;
  var pmo;

  ComentarAtividadeState(id) {
    pmo = id;
  }

  void SalvarComentario() {

    Map<String, String> params = {
      "pmo": pmo.toString(),
      "firstuser": 'oberdan',
      "observacoes": myController.text
    };

    Webservice().send(Atividades.all, params: params ).then((itemAtividade) => {
      setState(() => {

      })
    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 56,
        padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4
              )
            ]
        ),
        width: MediaQuery.of(context).size.width,
        child: Container (
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.call_to_action),
                      hintText: 'Detalhes do atendimento'
                  ),
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              IconButton(
                icon: Icon(Icons.insert_comment),
                color: Colors.black54,
                onPressed: () => SalvarComentario()
              ),
            ],
          ),
        )
    );
  }
}