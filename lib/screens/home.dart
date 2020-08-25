import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/screens/settingsform.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brewlist.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    void _settings(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child:settingsform()
        );
      });

    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Together'),
          backgroundColor: Colors.red,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person_outline),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signout();
              },
            ),

          ],
        ),
        body: BrewList(),
        floatingActionButton: FloatingActionButton (
          onPressed:()=> _settings(),
          elevation: 5.0,
          backgroundColor: Colors.red,
          child:Icon(Icons.settings) ,),
    )
    );
  }
}