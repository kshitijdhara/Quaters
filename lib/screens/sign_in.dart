
import 'package:brewcrew/screens/home.dart';
import 'package:brewcrew/screens/register.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/services/database.dart';
import 'package:flutter/material.dart';

import 'package:brewcrew/loadingpage.dart';


class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn({ this.toggle });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error='';
  String group='';

  bool load= false;

  @override
  Widget build(BuildContext context) {
    if(load==false){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Sign in to Quaters'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.swap_horizontal_circle),
            label: Text('Register'),
            onPressed: () => widget.toggle(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: 'email',fillColor: Colors.white,filled: true,
                    enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.indigoAccent ,
                        width: 2.0)) ),

                validator: (val) => val.isEmpty ? 'Enter email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: 'password',fillColor: Colors.white,filled: true,
                    enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.indigoAccent ,
                        width: 2.0)) ),
                validator: (val) => val.length < 6 ? 'Password is weak' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: 'group',fillColor: Colors.white,filled: true,
                    enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.indigoAccent ,
                        width: 2.0)) ),
                validator: (val) => val.length < 3 ? 'group name is weak' : null,
                onChanged: (val) {
                  setState(() {
                    group = val;
                    _auth.g=val;
                  });
                },
              ),

              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.red,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState.validate()){
                      setState(() {
                        load = true;
                      });

                      dynamic q= await _auth.emailandpassword(email, password, group);
                      if(q == null){
                        setState(() {
                          error='*enter valid email';
                          load=false;
                        });
                      }


                    }
                  }
              ),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(color: Colors.blue,fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
  else{
    return loading();

  }
  }
}