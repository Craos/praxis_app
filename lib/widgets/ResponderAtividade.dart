import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ResponderAtividade extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BarradeComandosAtividades();
  }
}

class BarradeComandosAtividades extends State<ResponderAtividade> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: new Row(

            ),
          )
        ],
      ),
    );
  }
}
