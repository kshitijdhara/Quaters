import 'package:brewcrew/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

  final Brew brewt;
  BrewTile({this.brewt});
  @override



  Widget build(BuildContext context) {

    return Padding(padding: EdgeInsets.only(top:8.0,left: 5.0),
    child: Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
        leading: CircleAvatar(radius: 25.0,backgroundColor: Colors.red[brewt.strength],),
        title: Text(brewt.name,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),),
        subtitle: Text('Takes ${brewt.sugars} ml of ${brewt.spirit} in group ${brewt.group}',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),

      ),
    ),);
  }
}


