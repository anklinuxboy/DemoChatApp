import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/ETMIQnEmrcwPqGQifXyp/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = streamSnapshot.data.documents;
          return ListView.builder(
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(docs[index]['text']),
            ),
            itemCount: streamSnapshot.data.documents.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/ETMIQnEmrcwPqGQifXyp/messages')
              .add({'text': 'floating action button clicked!'});
        },
      ),
    );
  }
}
