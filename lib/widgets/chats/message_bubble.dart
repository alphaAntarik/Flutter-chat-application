import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;

  final bool byme;
  final Key key;

  MessageBubble(this.message, this.username, this.userImage, this.byme,
      {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
          byme ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: byme ? Colors.grey[300] : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !byme ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: byme ? Radius.circular(12) : Radius.circular(0),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                byme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: byme
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.titleSmall.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: byme
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.titleSmall.color,
                    ),
                    textAlign: byme ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: byme ? null : 120,
          right: byme ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userImage,
            ),
          ),
        ),

      ],
      clipBehavior: Clip.none,
    );
  }
}
