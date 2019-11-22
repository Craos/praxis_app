import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:praxis/widgets/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarouselPage extends StatelessWidget {
  confirmaPrimeiroAcesso(context) async {

    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.clear();
    sharedPreferences.setString("primeiroacesso", "visto");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: <Widget>[
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: true,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1270),
                dotSize: 6.0,
                dotIncreasedColor: Color(0xFFFF335C),
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.topCenter,
                dotVerticalPadding: 10.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                images: [
                  ExactAssetImage("images/1.png"),
                  ExactAssetImage("images/2.jpg"),
                  ExactAssetImage("images/3.jpg"),
                  ExactAssetImage("images/4.jpg"),
                  ExactAssetImage("images/5.jpg"),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Iniciar",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          confirmaPrimeiroAcesso(context);
                        },
                      )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}