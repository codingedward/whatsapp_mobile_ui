import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class StatusList extends StatelessWidget {
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        this._buildMyStatusItem(),
        this._buildGap('Recent Updates'),
        ...List<Widget>.generate(2, (i) => this._buildStatusItem()),
        this._buildGap('Viewed Updates'),
        ...List<Widget>.generate(2, (i) => this._buildStatusItem())
      ],
    );
  }

  Widget _buildGap(String gapText) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            gapText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  Widget _buildMyStatusItem() {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  child: Image.asset(
                    'lib/assets/imgs/avatar_contact.png',
                    fit: BoxFit.cover,
                    width: 55,
                    height: 55,
                  ),
                  borderRadius: BorderRadius.circular(27.5),
                ),
                Positioned(
                  left: 35,
                  top: 25,
                  child: Badge(
                    elevation: 0,
                    padding: EdgeInsets.all(3),
                    badgeColor: Color(0xff25d366),
                    badgeContent: Text(
                      '+',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ],
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
                            'My status',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 3),
                        Expanded(
                            child: Text(
                          'Tap to add status update',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem() {
    final minutes = _random.nextInt(60);
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
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
              borderRadius: BorderRadius.circular(27.5),
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
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 3),
                        Expanded(
                            child: Text(
                          '$minutes minutes ago',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                      ],
                    ),
                    Divider(
                      height: 30,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
