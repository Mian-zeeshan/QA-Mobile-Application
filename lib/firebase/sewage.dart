import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('sewage');

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc("srUe9JcMpYgIR8AnxUD8").get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return Text(" ${data['ipname']} ");

            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}
