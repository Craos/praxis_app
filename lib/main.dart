import 'package:flutter/material.dart';
import 'package:praxis/utilidades/constants.dart';
import 'package:praxis/widgets/Apresentacao.dart';
import 'package:praxis/widgets/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(PraxisApp());

class PraxisApp extends StatelessWidget {

  bool first = true;

  PraxisApp() {
    _read();
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'first';
    first = (prefs.getInt(key) != 1) ?? true;
    print('first: $first');
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'first';
    final value = 1;
    prefs.setInt(key, value);
    print('saved $value');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData temadoPraxis = ThemeData(
        backgroundColor: Color(0xfff4f6fb),
        primaryColor: Colors.indigo,
        toggleableActiveColor: Colors.deepPurple,
        errorColor: Colors.deepOrange,
        textTheme: new TextTheme(
            body1: new TextStyle(color: Colors.black45, fontSize: 14),
            title: new TextStyle(color: Colors.indigo, fontSize: 16)));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.APP_NAME,
      theme: temadoPraxis,
      home: (first) ? CarouselPage() : Home(title: Constants.APP_NAME),
    );
  }
}
