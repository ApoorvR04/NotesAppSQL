import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DBHelper.dart';

class Addnote extends StatefulWidget {
  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  String title ='';
  String body='';



  void _insert( title,  body) async {
    final dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.title: title,
      DatabaseHelper.body: body,
    };
    final id = await dbHelper.insert(
      row,
    );



  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(

              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                        Navigator.of(context).pop();
                      },

                          child: Icon(Icons.keyboard_backspace),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)))
                      ),),

                      ElevatedButton(onPressed: add,
                          child: Icon(Icons.assignment_turned_in_outlined),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)))
                        ),)
                    ],

                  ),
                ),


                //
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Form(
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: "Title"),
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                            onChanged: (_val) {
                              title = _val;
                            },
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            child: TextField(
                              decoration: InputDecoration.collapsed(
                                  hintText: "...Note..."),
                              style: TextStyle(fontSize: 20.0),
                              onChanged: (_val) {
                                body = _val;
                              },
                              maxLines: null,

                            ),
                          )
                        ],
                      )),
                )
              ],
            )


        ),
      ),
    );



  }
  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('user').doc(FirebaseAuth.instance.currentUser.uid)
            .collection('notes');

    var data = {
      'title' : title,
      'body' : body,

    };
    _insert(this.title, this.body);
    ref.add(data);

    Navigator.pop(context);
}


}