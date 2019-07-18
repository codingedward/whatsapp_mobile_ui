import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';

class CallList extends StatelessWidget {
  final _random = math.Random();

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
    final missed = _random.nextBool();
    return Container(
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
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      missed 
                        ? Icon(Icons.call_made, color: Color(0xff25d366))
                        : Icon(Icons.call_missed_outgoing, color: Colors.red[600]),
                      Expanded(
                        child: Text(
                          'May 12, 5:40 PM',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                  )
                ],
              )
            ),
          ),
          Icon(Icons.call, color: Color(0xff25d366),)
        ],
      ),
    );
  }
}
