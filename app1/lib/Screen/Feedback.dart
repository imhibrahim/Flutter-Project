import 'package:app1/Screen/Cart.dart';
import 'package:flutter/material.dart';
import 'package:app1/Screen/AllUsers.dart';
import 'package:app1/Screen/Category.dart';
import 'package:app1/Screen/Feedback.dart';
import 'package:app1/Screen/Product.dart';
import 'package:app1/Screen/Register.dart';
import 'package:app1/Screen/Wishlist.dart';

class Feedbackpage extends StatefulWidget {
  const Feedbackpage({super.key});

  @override
  State<Feedbackpage> createState() => _FeedbackpageState();
}

class _FeedbackpageState extends State<Feedbackpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [

            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                
              ),
              child: Center(child: 
            
              Text("Watch Hub...", style: TextStyle(
      fontWeight: FontWeight.bold, // Makes the text bold
      fontSize: 30, 
      color: const Color.fromARGB(201, 248, 138, 4)// Adjust the font size
    ),))
              ),
              ListTile( 
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                },
              ),
              ListTile(
                leading: Icon(Icons.category),
                title: Text("Category"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
                },
              ),
              ListTile(
                leading: Icon(Icons.production_quantity_limits),
                title: Text("Product"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Product()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("User"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Allusers()));
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: Text("FeedBack"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Feedbackpage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text("WishList"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Wishlist()));
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text("Cart"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                },
              )
          ],
        ),
      ),

body: Center(
    child: Container(
      width: 1000,
      height: 1000,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 68, 227, 255),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          "Welcome to Watch Hub",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    )

),
);;
  }
}