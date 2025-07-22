import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recycle_me/services/shared_pref.dart';

import '../pages/home.dart';
import 'dabase.dart';

class AuthMethod{

  signInWithGoogle(BuildContext context) async{
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );
    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? user = result.user;

    await SharedPrefHelper().savedUserEmail(user!.email!);
    await SharedPrefHelper().savedUserId(user.uid);
    await SharedPrefHelper().savedUserName(user.displayName!);
    await SharedPrefHelper().savedUserImage(user.photoURL!);

    if(result != null){
      Map<String, dynamic> userInforMap = {
        "name": user!.displayName,
        "email": user.email,
        "profilePic": user.photoURL,
        "Id": user.uid,
        "Points": "0",
      };

      await DatabaseMethods().addUserInfo(userInforMap, user.uid);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}