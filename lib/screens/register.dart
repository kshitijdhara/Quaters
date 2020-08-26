import 'package:brewcrew/loadingpage.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {

  final Function toggle;
  register({ this.toggle });

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();


  // text field state
  String email = '';
  String password = '';
  String error = '';
  String group='';

  bool load = false;

  @override
  Widget build(BuildContext context) {
    if (load == false) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
          title: Text('Register to Together'),
          actions: <Widget>[
            FlatButton.icon(
              label: Text('Sign In'),
              icon: Icon(Icons.swap_horizontal_circle),

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
                  decoration: InputDecoration(hintText: 'Email',
                      fillColor: Colors.white, filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepOrangeAccent,
                              width: 2.0
                          )
                      )),
                  validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password',
                      fillColor: Colors.white, filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepOrangeAccent,
                              width: 2.0
                          )
                      )
                  ),
                  validator: (val) =>
                  val.length < 6
                      ? 'Password is weak'
                      : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Group',
                      fillColor: Colors.white, filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepOrangeAccent,
                              width: 2.0
                          )
                      )
                  ),
                  validator: (val) =>
                  val.length < 3
                      ? 'Group is weak'
                      : null,

                  onChanged: (val) {
                    setState(() =>group = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.red,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          load=true;
                        });

                        dynamic res = await _auth.regis(email, password,group);
                        if (res == null) {
                          setState(() {
                            error = 'please supply a valid email';
                            load=false;
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.blue, fontSize: 15.0),
                )
              ],
            ),
          ),
        ),
      );
    }
    else {
      return loading();
    }
  }
}
