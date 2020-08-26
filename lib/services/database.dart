import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/screens/authenticate.dart';
import 'package:brewcrew/screens/settingsform.dart';
import 'package:brewcrew/screens/sign_in.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

  final String uid;


  DatabaseService({ this.uid})
  {if (groupi == null){
    groupi='new group';
  }}


  // collection reference
  //final CollectionReference brewCollection = Firestore.instance.collection('groups');
  static String groupi=null;
  
  Future<void> updateUserData(String sugars, String name, int strength,String group,String spirit) async {
    groupi=group;
    return await Firestore.instance.collection(groupi).document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
      'groupid': group,
      'spirit': spirit,
    });


  }

  Future<void> deleteuserdata() async{
    return await Firestore.instance.collection(groupi).document(uid).delete();
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);

      return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0',
          group:doc.data['groupid'],
          spirit:doc.data['spirit'],
      );
    }).toList();
  }

  //userdata from snapshot
  UserData _userdatatosnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      name:snapshot.data['name'],
      strength:snapshot.data['strength'],
      sugars:snapshot.data['sugars'],
      groupid: snapshot.data['groupid'],
      spirit: snapshot.data['spirit'],
    );

  }
  

  // get brews stream
  Stream<List<Brew>> get brews {
    return Firestore.instance.collection(groupi).snapshots()
        .map(_brewListFromSnapshot);
  }

  Stream<UserData> get userdata{
    return Firestore.instance.collection(groupi).document(uid).snapshots().map(_userdatatosnapshot);
  }



}
