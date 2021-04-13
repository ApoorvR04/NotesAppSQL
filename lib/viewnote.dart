import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DBHelper.dart';

class Viewnote extends StatefulWidget {
  final Map data;
  final DocumentReference ref;

  Viewnote(this.data, this.ref);

  @override
  _ViewnoteState createState() => _ViewnoteState();
}

class _ViewnoteState extends State<Viewnote> {
  String title = '';
  String body = '';


  void _delete() async {
    final dbHelper = DatabaseHelper.instance;

    final id = await dbHelper.delete(1);

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
                      ElevatedButton(onPressed: () {
                        Navigator.of(context).pop();
                      },
                          child: Icon(Icons.keyboard_backspace),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)))
                        ),),
                      ElevatedButton(onPressed: delete,
                          child: Icon(Icons.delete_rounded),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange,
                            side: BorderSide(color: Colors.red, width: 5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)))
                        ),)
                    ],

                  ),
                ),


                //
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10.0),
                  child: Column(

                    children: [
                      Text("${widget.data['title']}",

                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),

                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        child: Text("${widget.data['body']}",

                          style: TextStyle(fontSize: 20.0),

                          maxLines: null,

                        ),
                      )
                    ],
                  ),
                )
              ],
            )


        ),
      ),
    );
  }

  void delete() async {

    await widget.ref.delete();

    Navigator.pop(context);
  }
}