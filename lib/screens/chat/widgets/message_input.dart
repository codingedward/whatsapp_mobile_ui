import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'emoji_picker.dart';
import 'emoji_support/emoji_text_field.dart';


class MessageInput extends StatefulWidget {

  const MessageInput({
    Key key,
    @required this.onCamera,
    @required this.onTextChange,
    @required this.onAttachment,
  }) : super(key: key);

  final VoidCallback onTextChange;
  final VoidCallback onAttachment;
  final VoidCallback onCamera;

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> with SingleTickerProviderStateMixin {
  bool _emojiInputShown = false;
  AnimationController _animationController;
  TextEditingControllerWithPosition _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingControllerWithPosition();
    _animationController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 200),
    )..repeat();
  }

  _onToggleEmojiInput() {
    SystemChannels.textInput.invokeMethod(
      'TextInput.${!_emojiInputShown ? 'hide' : 'show' }'
    );
    if (! _emojiInputShown) {
      Timer(Duration(milliseconds: 200), () {
        setState(() {
          _emojiInputShown = true;
        });
      });
    } else {
      setState(() {
        _emojiInputShown = false;
      });
    }
  }

  _onTextFieldTapped() {
    setState(() {
      _emojiInputShown = false;
    });
  }

  Future<bool> _onWillPop() async {
    if (_emojiInputShown) {
      setState(() {
        _emojiInputShown = false;
      });
      return false;
    }
    return true;
  }
  
  @override
  void dispose() {
    _textController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
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
                          onPressed: _onToggleEmojiInput,
                          icon: Icon(
                            _emojiInputShown ? Icons.keyboard : Icons.tag_faces, 
                            color: Colors.black54,
                          ),
                        ),
                        Expanded(
                          child: EmojiTextField(
                            minLines: 1,
                            maxLines: 6,
                            onTap: _onTextFieldTapped,
                            cursorColor: const Color(0xff075e54),
                            controller: _textController,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
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
                        AnimatedBuilder(
                          animation: _animationController,
                          child:IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.photo_camera, color: Colors.black54,),
                          ),
                          builder: (BuildContext context, Widget child) {
                            return child;
                            /*return Transform.translate(
                              //offset: _animation.value,
                              offset: Offset(_animationController.value * 100, 0),
                              child: child,
                            );
                            */
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff075e54),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic),
                    color: Colors.white,
                  )
                )
              ],
            ),
          ),
          if (_emojiInputShown) Container(
            constraints: BoxConstraints(
              maxHeight: 282,
            ),
            child: EmojiPicker(
              onEmojiPressed: (String emoji) {
                _textController.setTextAndPosition(
                  _textController.text + emoji
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TextEditingControllerWithPosition extends TextEditingController {
  TextEditingControllerWithPosition({String text}) : super(text: text);

  void setTextAndPosition(String newText, {int caretPosition}) {
    int offset = caretPosition != null ? caretPosition : newText.length;
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: offset),
        composing: TextRange.empty);
  }    
}