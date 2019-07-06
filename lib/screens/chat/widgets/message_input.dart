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
  Animation _animation;
  NoKeyboardFocusNode _focusNode;
  bool _noTextMode = true;
  bool _emojiInputShown = false;
  AnimationController _animationController;
  TextEditingControllerWithPosition _textController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 200)
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        setState(() {
          _noTextMode = _textController.text.isEmpty;
        });
      }
    });

    _textController = TextEditingControllerWithPosition();
    _textController.addListener(() {
      if (_textController.text.isEmpty) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurveTween(
        curve: Curves.easeOutCubic
      ).animate(_animationController)
    );
    _focusNode = NoKeyboardFocusNode();
  }

  _onToggleEmojiInput() {
    SystemChannels.textInput.invokeMethod('TextInput.${!_emojiInputShown ? 'hide' : 'show' }');
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
    _focusNode.dispose();
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
                            autofocus: true,
                            focusNode: _focusNode,
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
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (BuildContext context, Widget child) {
                            final offset = Offset(_animation.value * 50.0, 0);
                            final attachButton =  Transform.rotate(
                              angle: -pi / 4,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.attach_file, color: Colors.black54),
                              ),
                            );
                            return Row(
                              children: <Widget>[
                                _noTextMode ? 
                                Transform.translate(
                                  offset: offset,
                                  child: attachButton,
                                ) : attachButton,
                                if (_noTextMode) Opacity(
                                  opacity: _noTextMode ? 1 : _animation.value,
                                  child: Transform.translate(
                                    offset: offset,
                                    child: child,
                                  ),
                                ),
                              ],
                            );
                          },
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.photo_camera, color: Colors.black54,),
                          ),
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
                  child: AnimatedBuilder(
                    animation: _animation,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mic),
                      color: Colors.white,
                    ),
                    builder: (context, child) {
                      return Stack(
                        children: <Widget>[
                          Transform.scale(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.mic),
                              color: Colors.white,
                            ),
                            scale: (1 - _animation.value),
                          ),
                          Transform.scale(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.send),
                              color: Colors.white,
                            ),
                            scale: _animation.value,
                          )
                        ],
                      );
                    },
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
              onBackPressed: () {
                SystemChannels.keyEvent.send(8);
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
    print(newText);
    print(offset);
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: offset),
        composing: TextRange.empty);
  }    
}

class NoKeyboardFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() => false;
}