import 'dart:math';

import 'package:flutter/material.dart';

import 'widgets/message_input.dart';
import '../../widgets/emoji_rich_text.dart';

class Chat extends StatelessWidget {
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: NavigationToolbar.kMiddleSpacing - 20,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: <Widget>[
            ClipRRect(
              child: FadeInImage(
                image: NetworkImage('http://placekitten.com/40/40'),
                placeholder: AssetImage('lib/assets/imgs/avatar_contact.png'),
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            SizedBox(width: 10,),
            Text('Lucy Doe'),
          ]
        ),
        backgroundColor: Color(0xff075e54),
        actions: _buildActions(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('lib/assets/imgs/chat_background.png'),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 10, right: 10),
                itemCount: 100,
                itemBuilder: (context, index) {
                  if (index.isOdd) 
                    return _buildOtherText(context);
                  return _buildMyText(context);
                },
              ),
            ),
            MessageInput(
              onTextChange: () {},
              onCamera: () {},
              onAttachment: () {},
            ),
          ],
        ),
      )
    );
  }

  Widget _buildMyText(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minWidth: width * 0.4,
                maxWidth: width * 0.8
              ),
              margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Color(0xffdcf8c6),
              ),
              child: EmojiRichText(text: _getRandomText(), fontSize: 15,),
            ),
            Positioned(
              right: 0,
              child: ClipRect(
                clipper: ChatBoxTriangleClip(),
                child: Container(
                  child: Transform.rotate(
                    angle: pi / 4.0,
                    child: SizedBox(
                      width: 15,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffdcf8c6),
                        ),
                      ),
                    ),
                  ),
                ),
              ) ,
            ),
          ],
        )
      ] ,
    );
  }

  Widget _buildOtherText(BuildContext context) {
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
                  angle: -pi / 4.0,
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

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.videocam),
        onPressed: () {},
        tooltip: 'Video call',
      ),
      IconButton(
        icon: const Icon(Icons.call),
        onPressed: () {},
        tooltip: 'Call',
      ),
      IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {},
        tooltip: 'More',
      ),
    ];
  }

  String _getRandomText() {
    return [
      'Hi there', 
      'Hi man 🐣 😂😂😂, I will reach out to you as soon as we end the call',
      '😂😂😂😂😂😂😂😂😂😂',
    ][_random.nextInt(3)];
  }
}

class ChatBoxTriangleClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 10, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;

}