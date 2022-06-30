import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy(
            'timeStamp',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatsDocs = snapshot.data?.docs;
        final userId = FirebaseAuth.instance.currentUser?.uid;
        return ListView.builder(
          reverse: true,
          itemCount: chatsDocs?.length,
          itemBuilder: (context, index) => MessageBubble(
            chatsDocs?[index]['text'],
            chatsDocs?[index]['username'],
            chatsDocs?[index]['userId'] == userId,
            key: ValueKey(chatsDocs?[index].id),
          ),
        );
      },
    );
  }
}
