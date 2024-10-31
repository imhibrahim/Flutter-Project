import 'package:app1/Screen/ForgetPassword.dart';
import 'package:app1/Screen/Register.dart';
import 'package:app1/Screen/loginLogic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
 // const Login({super.key});
  final FirebaseAuthauth =FirebaseAuth.instance;


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   final TextEditingController _emailController=TextEditingController();
 final TextEditingController _PasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "- - Login Now - -", // Changed text
    style: TextStyle(
      fontWeight: FontWeight.bold, // Makes the text bold
      fontSize: 30, 
      color: const Color.fromARGB(227, 30, 191, 202)// Adjust the font size
    ),
  ),
        centerTitle: true, // Centers the title
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
        Image.asset("assest/images/user.png",height: 80,),

        // Spacer to push the rest of the content down
        SizedBox(height: 50), // Space between image and input fields
        
        // Input fields
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: "Enter Your Email"),
        ),
        SizedBox(height: 21),
        TextFormField(
          controller: _PasswordController,
          obscureText: true,
          obscuringCharacter: "*",
          decoration: const InputDecoration(labelText: "Enter Your Password"),
        ),
        SizedBox(height: 21),
       Material(
  elevation: 4, // Adjust the elevation for shadow effect
  shadowColor: Colors.black.withOpacity(0.9), // Color of the shadow
  borderRadius: BorderRadius.circular(18), // Adjust the border radius if needed
  child: ElevatedButton(
    onPressed:()=> login(
    context,_emailController.text,_PasswordController.text),
    
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 98, 221, 221), // Background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18), // Match button's border radius
      ),
    ),
    child: Text(
      "Login",
      style: TextStyle(
        color: const Color.fromARGB(227, 45, 46, 46), // Text color
      ),
    ),
  ),
),
        SizedBox(height: 21),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Register()),
            );
          },
          child: Text("Register Now ...", style: TextStyle(
      color: const Color.fromARGB(211, 0,12, 0)// Adjust the font size
    ),),
        ),
         SizedBox(
              height: 21,
        
            ),
            TextButton(onPressed:(){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Forgetpassword()),
);
            }, child: Text("Forget Password ...!!")
            )

      ],
    ),
  ),
)
        ),
      );;
  }
}