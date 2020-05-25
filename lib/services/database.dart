import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/models/brew.dart';
import 'package:firestore/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection=Firestore.instance.collection('brews');
  
  Future updateUserData(String sugars,String name,int strength)async{
    return await brewCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });
  }
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
    return Brew(
      name: doc.data['name'] ?? '',
      sugars: doc.data['sugars'] ?? 0,
      strengths:doc.data['strengths'] ?? 0
    );
    }).toList();
  }
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
uid:uid,
name:snapshot.data['name'],
sugars: snapshot.data['sugars'],
strength: snapshot.data['strengths']
  );
}
  Stream<List<Brew>> get bews{
  return brewCollection.snapshots()
  .map(_brewListFromSnapshot);
}
Stream<UserData> get useData{
  return brewCollection.document(uid).snapshots()
  .map((_userDataFromSnapshot));
}
}