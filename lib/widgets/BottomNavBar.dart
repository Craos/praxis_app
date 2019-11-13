import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomNavyBar extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return BottomNavBarState();
  }

}

class BottomNavBarState extends State<BottomNavyBar> {

  int selectedIndex = 0;
  Color backgroundColor = Colors.white;

  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.update), Text('Atividades'), Colors.blueAccent.withAlpha(80), Colors.indigo),
    NavigationItem(Icon(Icons.transfer_within_a_station), Text('Materiais'), Colors.orangeAccent.withAlpha(80), Colors.deepOrange),
    NavigationItem(Icon(Icons.tune), Text('Ajustes') , Colors.purpleAccent.withAlpha(80), Colors.deepPurple),
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 270),
        height: double.maxFinite,
        width: isSelected ? 125 : 50,
        padding: isSelected ? EdgeInsets.only(left: 12, right: 12) : null,
      decoration: isSelected ? BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.all(Radius.circular(50))
      ) : null,
       child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                      size: 24,
                      color: isSelected ? item.titlestyle : Colors.black
                  ),
                  child: item.icon,
                ), Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: isSelected ? DefaultTextStyle.merge(
                      style: TextStyle(
                          color: item.titlestyle,
                      ),
                      child: item.title
                  ) : Container(),
                )
              ],
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4
          )
        ]
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item){

          var itemIndex = items.indexOf(item);

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = itemIndex;
              });
            },
            child: _buildItem(item, selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {

  final Icon icon;
  final Text title;
  final Color titlestyle;
  final Color color;

  NavigationItem(this.icon, this.title, this.color, this.titlestyle);

}