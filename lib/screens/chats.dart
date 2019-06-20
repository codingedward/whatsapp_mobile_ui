import 'dart:math';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:badges/badges.dart';

class ChatList extends StatelessWidget {

  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return this._buildListItem();
      },
    );
  }

  Widget _buildListItem() {
    final hasBadge = this._random.nextBool();
    final isMute = this._random.nextBool();
    final badgesCount = this._random.nextInt(10) + 1;
    final sentStatus = this._random.nextInt(4);

    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: ClipRRect(
              child: FadeInImage(
                image: NetworkImage('http://placekitten.com/60/60'),
                placeholder: AssetImage('lib/assets/imgs/avatar_contact.png'),
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          WordPair.random().asPascalCase, 
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Text('Yesterday')
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      this._buildSentStatus(sentStatus),
                      SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          'Hi man 🐣 😂😂😂, I will reach out to you as soon as we end the call',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ),
                      if (isMute) Icon(Icons.volume_off, color: Colors.grey,),
                      if (hasBadge) SizedBox(width: 3),
                      if (hasBadge) Badge(
                        elevation: 0,
                        padding: EdgeInsets.all(7),
                        badgeColor: Color(0xff25d366),
                        badgeContent: Text(
                          badgesCount.toString(), 
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 50,
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );
  }

  Icon _buildSentStatus(int status) {
    switch (status) {
      case 0: return Icon(Icons.access_time, color: Colors.grey, size: 20,);
      case 1: return Icon(Icons.done, color: Colors.grey, size: 20,);
      case 2: return Icon(Icons.done_all, color: Colors.grey, size: 20,);
      case 3: return Icon(Icons.done_all, color: Colors.blue, size: 20,);
    }
  }
}