// We are using firestore 
// the user signs in using google account and on the same page, after the user signs up, change the button and show the dopdown and ask them their status 
// in the backend, the data at each index will be stored with email at the top and then the status string datafield, then their location datafield, which will be double or floats for gps coordinates
// I have to create an insteance of each user, so in this file, I will expose a const public user, which can be acessed from all other classes. The other guys just have to import this class and then call the user for acessing data
// Read write functions will also be user.write() or something like that, which can be acessed form the other classes
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:testProject/InputOutput.dart';
import 'package:testProject/Screens/checkStatus.dart';



class AuthService {
  bool loginStatus = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _dbFireStore = Firestore.instance;

  Stream<FirebaseUser> user; // The user itself
  Stream<Map<String, dynamic>> profile; // User info in fire store
  PublishSubject loading = PublishSubject(); // For pushing new values to manually
  String status; 
  // InputOutput storage;

  AuthService(){

    user = _auth.onAuthStateChanged;

    // storage = InputOutput();
    // this.storage ;

    profile = user.switchMap((FirebaseUser u) {
      if(u != null) {
        return _dbFireStore.collection('users').document(u.uid).snapshots().map((snap) => snap.data);
      } else {
        return Stream.empty();
      }
    });
  }
  
  // Takes them to the google account for login
  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    // For signing the user into google
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    // For signing the user into firebase
    final AuthCredential credential = 
      GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

    updateUserData(user);
    loading.add(false);
    loginStatus = true;
    // TODO: Make this work
    inputOutput.createFile(user);
    return user;
  }
  
  // Updates user data in fire store
  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _dbFireStore.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'imageUrl': user.photoUrl,
      'currentStatus': status,
    }, merge: true);
  }

  void signOut() {
    _auth.signOut();
  }

  propertyData <String>(String propertyName) {
    return user.toList();
  }

}

// For acessing the database outside this class
final AuthService authService = AuthService();

