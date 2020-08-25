import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future siginAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
Future emailandpassword(String email,String pwd,String group) async{
    try{
      AuthResult r=await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      FirebaseUser user=r.user;
      await DatabaseService(uid: user.uid).updateUserData('30', 'new user', 100, group,'vodka');
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
}

  // register with email and password
Future regis(String email, String pwd, String group ) async{
    try{
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: pwd);
      FirebaseUser user=result.user;
      await DatabaseService(uid: user.uid).updateUserData('30', 'new user', 100,group,'vodka');
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;


    }

}

  // sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  String g='group';
  String groupd(String group){
    g=group;
  }

}
