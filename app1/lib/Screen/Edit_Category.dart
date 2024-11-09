import 'package:app1/Screen/Cart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app1/Screen/AllUsers.dart';
import 'package:app1/Screen/Category.dart';
import 'package:app1/Screen/Feedback.dart';
import 'package:app1/Screen/Product.dart';
import 'package:app1/Screen/Register.dart';
import 'package:app1/Screen/Wishlist.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditCategories extends StatefulWidget {
  //const EditCategories({super.key});
final String postId;
final String title;
final String description;
//constructor
EditCategories(
  {required this.postId,
   required this.title,
    required this.description}
    );




  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
   final titleController=TextEditingController();
  final descController=TextEditingController();
//add reference
final DatabaseRef =FirebaseDatabase.instance.ref('Post');
// on Screen load
void initState(){
  super.initState();
  titleController.text=widget.title;
  descController.text=widget.description;
}
//method update
void _UpdateCategory()async{
  String new_title=titleController.text;
  String new_description=descController.text;
  await DatabaseRef.child(widget.postId).update({
    'Title':new_title,
    "Description":new_description,
  });
  print("Data Inserted Seccfully ...!");
   //alert
   Fluttertoast.showToast(msg: "Data inserted Successfully added ....");
    //clear feilds
    titleController.clear();
    descController.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (
      context)=>Categories()));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit To Post"),
      ),drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  "Watch Hub...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: const Color.fromARGB(201, 248, 138, 4),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Category"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Categories())); // Close drawer without pushing a new route
              },
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits),
              title: Text("Product"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Product()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("User"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Allusers()));
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Feedbackpage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Wishlist"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text("Cart"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
              },
            ),
          ],
        ),
      ),
      body: 
     Padding(
       padding: const EdgeInsets.all(18.0),
       child: Column(
        children: [
          Text("Update Post"),

          SizedBox(height: 21,),
          TextFormField(
            controller:titleController,
            decoration: InputDecoration(hintText: "Add Title", border: OutlineInputBorder()),),
            
           SizedBox(height: 21,),
          TextFormField(
            controller:descController,
            decoration: InputDecoration(hintText: "Add Description", border: OutlineInputBorder()),),
          SizedBox(height: 21,),

          ElevatedButton(onPressed: _UpdateCategory, child: Text("Update Data"))
        ],
       
       ),
     )
    );
  }
}