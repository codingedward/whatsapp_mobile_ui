import 'dart:math';

import 'package:flutter/material.dart';


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
            Text('Doe'),
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
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.tag_faces, color: Colors.black54,),
                          ),
                          const Expanded(
                            child: const TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type a message'
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: -pi / 4,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.attach_file, color: Colors.black54),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.photo_camera, color: Colors.black54,),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff075e54),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mic),
                      color: Colors.white,
                    )
                  )
                ],
              ),
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
              child: Text(
                _getRandomText(),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
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
              child: Text(_getRandomText()),
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
                      decoration: BoxDecoration(
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
        icon: const Icon(Icons.video_call),
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