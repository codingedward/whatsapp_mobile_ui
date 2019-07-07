import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../widgets/emoji_rich_text.dart';
import 'chatbox_clip.dart';

class ReceivedMessageChatBox extends StatelessWidget {

  final _random = math.Random();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minWidth: width * 0.4,
                maxWidth: width * 0.8
              ),
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Colors.white,
              ),
              child: EmojiRichText(text: _getRandomText(), fontSize: 15,),
            ),
            ClipRect(
              clipper: ChatBoxTriangleClip(),
              child: Container(
                child: Transform.rotate(
                  angle: -math.pi / 4.0,
                  child: SizedBox(
                    width: 15,
                    height: 20,
                    child: Container(
                      decoration:  BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ] ,
    );
  }

  String _getRandomText() {
    return [
      'Hi there', 
      'Hi man 🐣 😂😂😂, I will reach out to you as soon as we end the call',
      '😂😂😂😂😂😂😂😂😂😂',
    ][_random.nextInt(3)];
  }
}