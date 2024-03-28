import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Foryou extends StatefulWidget {
  const Foryou({Key? key}) : super(key: key);

  @override
  _ForyouState createState() => _ForyouState();
}

class _ForyouState extends State<Foryou> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 50), (Timer timer) {
      setState(() {}); // Reload the page every 50 seconds
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tweets')
            .orderBy('timestamp', descending: true) // Order by timestamp in descending order
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(
              child:  Text('No tweets found.'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              return Column(
                children: [
                  Card(
                    elevation: 0,
                    shadowColor: Colors.blue,
                    child: ListTile(
                      title: Text(data['text'] ?? ''),
                      subtitle: data['image_url'] != null
                          ? Image.network(data['image_url'] ?? '')
                          : null,
                      // Add additional widgets to display other tweet information
                    ),
                    
                    
                  ),
                  const Divider( color: Colors.grey,)
                ],
              );
            }

            ).toList(),
          );
        },
      ),
    );
  }
}
