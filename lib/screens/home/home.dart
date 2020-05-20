import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firestore/services/database.dart';
import 'package:provider/provider.dart';  
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/screens/home/brew_list.dart';
import 'package:firestore/models/brew.dart';
import 'package:firestore/screens/home/setting_form.dart';
class Home extends StatelessWidget {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingPanel(){
      showModalBottomSheet(context: context, 
      builder: (context){
        return Container(
          padding:EdgeInsets.symmetric(vertical: 20,horizontal: 60),
        child: SettingsForm(),
        
        );
      });
    }
    return  StreamProvider<List<Brew>>.value(
          value:DatabaseService().bews,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title:Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed:() async {
                await _auth.signOut();
              },
               icon: Icon(Icons.person),
                label: Text('Logout')),
                FlatButton.icon(onPressed: (){
                  _showSettingPanel();
                }, icon: Icon(Icons.settings), label: Text('settings'))
          ],
        ),
        body: BrewList(),
      ),
    );
    
  }
}