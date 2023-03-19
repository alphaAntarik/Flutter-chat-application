import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enterMessage = '';
  void _sentMessage() async{
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text' : _enterMessage,
      'createdAt' : Timestamp.now(),
      'userid' : user.uid,
      'username': userData.data()['username'],
      'userImage': userData.data()['image_url']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(

              child: TextField(

                controller: _controller,
            decoration: InputDecoration(labelText: 'Send a message'),
            onChanged: (value) {
              setState(() {
                _enterMessage = value;
              });
            },
          )),
          IconButton(
            onPressed: _enterMessage.trim().isEmpty ? null : _sentMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
