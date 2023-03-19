import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (ctx, futureSnapShot) {
          if (futureSnapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, chatsnapshot) {
                if (chatsnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final chatDocs = chatsnapshot.data.docs;

                return ListView.builder(
                    itemCount: chatDocs.length,
                    reverse: true,
                    itemBuilder: (ctx, index) => MessageBubble(
                      chatDocs[index].data()['text'],
                      chatDocs[index].data()['username'],
                      chatDocs[index].data()['userImage'],
                      chatDocs[index].data()['userid'] == user.uid,
                      key: ValueKey(chatDocs[index].id),  )
                );
              });
        });
  }
}
