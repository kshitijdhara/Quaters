import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/screens/home.dart';
import 'package:brewcrew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../loadingpage.dart';



class settingsform extends StatefulWidget {
  @override
  _settingsformState createState() => _settingsformState();
}

class _settingsformState extends State<settingsform> {
  @override

   String group;
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','30', '60', '90',];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  String currentgroup;
  String currentspirit='vodka';

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userdata,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Settinggs for group - ${userData.groupid}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                      decoration: InputDecoration(labelText: 'Name' , enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent,width: 2.0)
                      )),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0,),
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData.sugars,
                    decoration: InputDecoration(labelText: 'Alchol ' , enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent,width: 2.0)
                    )),
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar ml'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val ),
                  ),
                  SizedBox(height: 20.0),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.red[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.red[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState((){
                      _currentStrength = val.round();
                      if(_currentStrength==100)
                        currentspirit='vodka';
                      else if(_currentStrength==200)
                        currentspirit='rum';
                      else if(_currentStrength==300)
                        currentspirit='whisky';
                      else if(_currentStrength==400)
                        currentspirit='beer';
                      else if(_currentStrength==500)
                        currentspirit='gin';
                      else if(_currentStrength==600)
                        currentspirit='wine';
                      else if(_currentStrength==700)
                        currentspirit='brandy';
                      else if(_currentStrength==800)
                        currentspirit='scotch';
                      else if(_currentStrength==900)
                        currentspirit='cocktail';


                    }),
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        currentspirit,
                        style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900),
                      ),

                    ],
                  ),
                  SizedBox(height: 10.0,),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? snapshot.data.sugars,
                              _currentName ?? snapshot.data.name,
                              _currentStrength ?? snapshot.data.strength,
                            currentgroup??snapshot.data.groupid,
                            currentspirit??snapshot.data.spirit,
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),

                ],
              ),
            );
          } else {
            return loading();
          }
        }
    );
  }
}
