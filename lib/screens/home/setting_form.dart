import 'package:firestore/models/user.dart';
import 'package:firestore/services/database.dart';
import 'package:firestore/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
final _formKey=GlobalKey<FormState>();
final List<String> sugars=['0','1','2','3','4'];

String _currentName;
String _currentSugars;
int _currentStengths;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).useData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData=snapshot.data;
   return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Update the brew setting',
              style: TextStyle(
                fontSize: 18 
              ),),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: userData.name,
                validator: (val)=>val.isEmpty?'please enter a name':null,
                onChanged: (val)=> setState(()=> _currentName = val),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                value: _currentSugars ?? userData.sugars,
                items: sugars.map((e){
                return DropdownMenuItem(
                  child: Text('$e sugars'),
                value: e,
                );
                }).toList(),
                onChanged: (val)=> setState(()=>_currentSugars=val),
                ),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor: Colors.brown[_currentStengths??100],
                  inactiveColor: Colors.brown[_currentStengths??100],
                  value: (_currentStengths ?? 100).toDouble(), 
                  onChanged: (val)=>setState(()=>_currentStengths=val.round()
                  )
                  ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text('update'),
                onPressed: () async{
                if(_formKey.currentState.validate()){
                  await DatabaseService(uid: user.uid).updateUserData(
                    _currentSugars ?? userData.sugars,
                    _currentName ?? userData.name, 
                    _currentStengths ??userData.strength);
                    Navigator.pop(context);
                }
              })
            ],
          ),
        );
        }else{
          return Loading();
        }
     
      }
    );
  }
}