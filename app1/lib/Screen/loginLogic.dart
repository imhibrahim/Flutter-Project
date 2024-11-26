import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app1/Screen/Login.dart';


const String admin="imh774077@gmail.com";

 final FirebaseAuth auth =FirebaseAuth.instance;

 void login(BuildContext context,String email,String password)async{
try{
UserCredential userCredential=await auth.
signInWithEmailAndPassword(email: email, password: password);

if(userCredential.user!.email==admin){
    //show success msg terminal
    print("Admin Login Successfully added ....");
    //alert msg
    Fluttertoast.showToast(msg: "Admin Login Successfully ....");
    //navigator
  Navigator.pushNamed(context, '/Admin');
}
else{
  //show success msg terminal
    print("User Login Successfully added ....");
    //alert msg
    Fluttertoast.showToast(msg: "User Login Successfully ....");
    //clear feilds
  
    //navigator
  Navigator.pushNamed(context,'/bottomnavigator');
}

}
catch(e){
 print("Login Failed ${e.toString()}");
     //alert msg
    Fluttertoast.showToast(msg: "Login Failed... ${e.toString()}");
}

 }