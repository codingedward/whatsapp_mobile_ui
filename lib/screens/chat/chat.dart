import 'package:flutter/material.dart';


import 'chatbox/received_message_chatbox.dart';
import 'chatbox/sent_message_chatbox.dart';
import 'input/message_input.dart';

class Chat extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        decoration: const BoxDecoration(
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
                itemCount: 20,
                itemBuilder: (context, index) {
                  if (index.isOdd) 
                    return SentMessageChatBox();
                  return ReceivedMessageChatBox();
                },
              ),
            ),
            MessageInput(
              onCamera: () {},
              onTextChange: () {},
              onAttachment: () {},
              keyboardHeight: isPortrait ? 280 : 200,
            ),
          ],
        ),
      )
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
}
