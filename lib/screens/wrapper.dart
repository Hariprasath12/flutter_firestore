import 'package:firestore/models/user.dart';
import 'package:firestore/screens/home/home.dart';
import 'package:flutter/material.dart';
// import 'package:firestore/screens/home/home.dart';
import 'package:firestore/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    //return either or auth widget
    if(user== null){
      return Authenticate();
    }else{
      return Home();
    }
  }
} 