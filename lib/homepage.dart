import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/newnote.dart';
import 'package:notes_app/viewnote.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('user').doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Notes",style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic
        ),),
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () { Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Addnote())

        ).then((value) {
          setState(() {

          });
        });

        },
        child: Icon(Icons.add_circle_outline_outlined),
      ),
      body: FutureBuilder(
        future: ref.get() ,
        builder: (context,snapshot){

          if (snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context,index){
                  Map data = snapshot.data.docs[index].data();
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Viewnote(data, snapshot.data.docs[index].reference))
                      ).then((value) {
                        setState(() {

                        });
                      });
                    },
                    child: Card(
                      color: Colors.orangeAccent.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${data['title']}",

                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0
                              ),

                            ),
                            Padding(padding: EdgeInsets.only(top: 10.0)),
                            Text("${data['body']}",
                              style: TextStyle(
                                   fontSize: 15.0,
                                ),

                              maxLines: 1,
                            ),


                          ],
                        ),
                      ),
                    ),
                  );

            });

          } else{
            return Center(

            );
          }
        })

    );
  }
}
