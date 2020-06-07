import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_app/widgets/chats/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnap) {
        if (futureSnap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final chats = chatSnapshot.data.documents;

              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, index) => MessageBubble(
                  chats[index]['text'],
                  chats[index]['userId'] == futureSnap.data.uid,
                  ValueKey(chats[index].documentID),
                  chats[index]['username'] == null
                      ? ''
                      : chats[index]['username'],
                ),
                itemCount: chats.length,
              );
            });
      },
    );
  }
}
