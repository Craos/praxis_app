import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ComentarAtividade extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ComentarAtividadeState();
  }

}

class ComentarAtividadeState extends State<ComentarAtividade> {

  Color backgroundColor = Colors.white;


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
                onPressed: () => null,
              ),
            ],
          ),
        )
    );
  }
}