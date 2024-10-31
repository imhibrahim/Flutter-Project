import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app1/Screen/Login.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final TextEditingController _emailController=TextEditingController();
  final FirebaseAuth auth=FirebaseAuth.instance;
void _resetPassword()async{
  try {
    final String email=_emailController.text.trim();
    await auth.sendPasswordResetEmail(email: email);
    print("Reset Your Password Is Done...!");

    Fluttertoast.showToast(msg:"Reset Your Password Is Done...!");
    _emailController.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()
    ));
  } catch (e) {
     Fluttertoast.showToast(msg:"Your Password Reset is Failed ...! ${e.toString()}");
     print("Your Password Reset is Failed ...! ${e.toString()}");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
       body: Center(
         child: Container(
  height: 500,
  width: 400,
  decoration: BoxDecoration(
    color: const Color.fromARGB(97, 210, 241, 239),
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: const Color.fromARGB(111, 124, 121, 121),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(5, 6),
      ),
    ],
    border: Border.all(
      color: const Color.fromARGB(255, 142, 221, 226),
      width: 4,
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(31.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // User image at the top
        Image.asset("assest/images/email_icon.gif",height: 100,),

        // Spacer to push the rest of the content down
        SizedBox(height: 50), // Space between image and input fields
        
        // Input fields
        TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email:" ,hintText: "Enter Your E-Mail"),

          ),
       
       
          SizedBox(height: 21,),
          ElevatedButton(onPressed: _resetPassword, child: Text("Reset Password"))
        ],
          
        ),
        

      
    ),
  ),

        ),
      // body: Column(
      //   children: [

      //     TextField(
      //       controller: _emailController,
      //       decoration: InputDecoration(labelText: "Email:" ,hintText: "Enter Your E-Mail"),

      //     ),
      //     SizedBox(height: 21,),
      //     ElevatedButton(onPressed: _resetPassword, child: Text("Reset Password"))
      //   ],
      // ),
    );
  }
}