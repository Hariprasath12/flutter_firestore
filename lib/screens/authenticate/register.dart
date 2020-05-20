import 'package:firestore/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firestore/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
   bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Register in Brew Crew'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign in'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Enter the email' : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.length < 6 ? 'Enter the Password' : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                            setState(() {
                  loading=true;
                });
                          dynamic result =
                              await _auth.registerWithEmail(email, password);
                          if (result == null) {
                            setState(() {
                                                            loading=false;

                              error = 'please supply a vaild email';
                            });
                          }
                        }
                      },
                      color: Colors.pink[400],
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(height: 20),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ))),
    );
  }
}
