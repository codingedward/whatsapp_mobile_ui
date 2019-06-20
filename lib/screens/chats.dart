import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class ChatList extends StatelessWidget {

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
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: ClipRRect(
              child: Image.network('http://placekitten.com/60/60'),
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
                      Icon(Icons.check, color: Colors.grey,),
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
                      Icon(Icons.volume_off, color: Colors.grey,),
                    ],
                  ),
                  Divider(
                    height: 20,
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}