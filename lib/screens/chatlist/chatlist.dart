import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:badges/badges.dart';

import '../../screens/chat/chat.dart';
import '../../widgets/emoji_rich_text.dart';

class ChatList extends StatelessWidget {
  final _random = math.Random();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return this._buildListItem(context);
      },
    );
  }

  Widget _buildListItem(BuildContext context) {
    final hasBadge = this._random.nextBool();
    final isMute = this._random.nextBool();
    final badgesCount = this._random.nextInt(10) + 1;
    final sentStatus = this._random.nextInt(4);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chat())
        );
      },
      child: Container(
        padding: EdgeInsets.only(right: 10, left: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: ClipRRect(
                child: FadeInImage(
                  image: NetworkImage('http://placekitten.com/55/55'),
                  placeholder: AssetImage('lib/assets/imgs/avatar_contact.png'),
                  fit: BoxFit.cover,
                  width: 55,
                  height: 55,
                ),
                borderRadius: BorderRadius.circular(27),
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
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Text(
                          'Yesterday',
                          style: TextStyle(
                            color: hasBadge ? Colors.green : Colors.grey[600]
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        this._buildSentStatus(sentStatus),
                        SizedBox(width: 3),
                        Expanded(
                          child: EmojiRichText(
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis,
                            text: _randomText(),
                          ),
                        ),
                        if (isMute) Icon(Icons.volume_off, color: Colors.grey,),
                        if (hasBadge) ...[
                          SizedBox(width: 5),
                          Badge(
                            elevation: 0,
                            padding: EdgeInsets.all(8),
                            badgeColor: Color(0xff25d366),
                            badgeContent: Text(
                              badgesCount.toString(), 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12
                              ),
                            ),
                          ),
                        ]                       
                      ],
                    ),
                    Divider(
                      height: 30,
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSentStatus(int status) {
    switch (status) {
      case 0: return Icon(Icons.access_time, color: Colors.grey, size: 20,);
      case 1: return Icon(Icons.done, color: Colors.grey, size: 20,);
      case 2: return Icon(Icons.done_all, color: Colors.grey, size: 20,);
      case 3: return Icon(Icons.done_all, color: Colors.blue, size: 20,);
    }
  }

  String _randomText() {
    return [
      'Hi man 🦙️ 🏳️\u200d🌈🐣😂😂, I will reach out as soon as we end the call',
      '😂😂😂😂😂',
      'Yeah totally',
    ][_random.nextInt(3)];
  }
}
