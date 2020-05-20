import 'package:flutter/material.dart';

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
            validator: (val)=>val.isEmpty?'please enter a name':null,
            onChanged: (val)=> setState(()=>_currentName=val),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField(
            value: _currentSugars ?? '0',
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
            onPressed: (){
            print(_currentName);
          })
        ],
      ),
    );
  }
}