import 'package:firestore/screens/authenticate/register.dart';
import 'package:firestore/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signIn=true;
void toggleView(){
  setState(() {
    signIn=!signIn;
  });
}

  @override
  Widget build(BuildContext context) {
    if(signIn){
return SignIn(toggleView: toggleView);
    }else{
return Register(toggleView: toggleView);
    }
  }
}