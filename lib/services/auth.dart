import 'package:agnostica/models/user.dart';
import 'package:agnostica/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object
  User _userFromFirebaseUser (FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }
  // auth stream user

  Stream<User>get user {
      return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }

  //signin anon
  Future signInAnon() async{
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //signin with email and password
  Future signin(String email, String password) async {
    try{
      dynamic result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if(result==null){
        return _userFromFirebaseUser(user);
      }
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //signin with google
  //reg with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      dynamic result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for every new user
      await DatabaseService(uid: user.uid).updateUserData('0', 'newCrewMember', 100);

      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}