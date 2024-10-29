import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app1/Screen/Login.dart';

class Register extends StatelessWidget {
 // const register({super.key});
 final FirebaseAuth auth =FirebaseAuth.instance;
 final TextEditingController _emailController=TextEditingController();
 final TextEditingController _PasswordController=TextEditingController();

  //function for register user
void _register()async{
  try {
    final String email= _emailController.text.trim();
    final String password= _PasswordController.text.trim();
   final UserCredential userCredential=await auth.
   createUserWithEmailAndPassword(email: email, password: password);
    //show success msg terminal
    print("Data inserted Successfully added ....");
    //alert msg
    Fluttertoast.showToast(msg: "Data inserted Successfully added ....");
    //clear feilds
    _emailController.clear();
    _PasswordController.clear();
     }

   catch(e){
    print("Regestration Failed ${e.toString()}");
     //alert msg
    Fluttertoast.showToast(msg: "Regestration Failed ${e.toString()}");
   }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "- - Register Now - -", // Changed text
    style: TextStyle(
      fontWeight: FontWeight.bold, // Makes the text bold
      fontSize: 30, 
      color: const Color.fromARGB(228, 23, 227, 241)// Adjust the font size
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
        SizedBox(height: 80), // Space between image and input fields
        
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
    onPressed: _register,
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 98, 221, 221), // Background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18), // Match button's border radius
      ),
    ),
    child: Text(
      "Register",
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
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: Text("Login Now ...", style: TextStyle(
      color: const Color.fromARGB(211, 0,12, 0)// Adjust the font size
    ),),
        ),
      ],
    ),
  ),
)
        ),
      );
  }
}