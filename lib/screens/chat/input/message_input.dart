import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'attachment_and_camera_button.dart';
import 'emoji_picker.dart';
import 'input_field.dart';
import 'input_mode_toggle_button.dart';
import 'send_and_mic_button.dart';

class TextEditingControllerWithPosition extends TextEditingController {

  TextEditingControllerWithPosition({
    String text
  }) : super(text: text);

  void setTextAndPosition(String newText, {int caretPosition}) {
    int offset = caretPosition != null ? caretPosition : newText.length;
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

class MessageInput extends StatefulWidget {

  MessageInput({
    Key key,
    @required this.onCamera,
    @required this.onTextChange,
    @required this.onAttachment,
    @required this.keyboardHeight,
  }) : super(key: key);

  final double keyboardHeight;
  final VoidCallback onTextChange;
  final VoidCallback onAttachment;
  final VoidCallback onCamera;

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> with SingleTickerProviderStateMixin {
  Animation _animation;
  bool _hideCameraButton = true;
  NoKeyboardFocusNode _focusNode;
  InputMode _inputMode = InputMode.NONE;
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
          _hideCameraButton = _textController.text.isEmpty;
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

  _onChangeInputMode(InputMode mode) {
    if (mode == InputMode.EMOJI) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Timer(Duration(milliseconds: 200), () {
        setState(() {
          _inputMode = mode;
        });
      });
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.show');
      setState(() {
        _inputMode = mode;
      });
    }
  }

  _onMessageFieldTapped() {
    setState(() {
      _inputMode = InputMode.TEXT;
    });
  }

  Future<bool> _onWillPop() async {
    if (_inputMode == InputMode.EMOJI) {
      setState(() {
        _inputMode = InputMode.NONE;
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
                        InputModeToggleButton(
                          mode: _inputMode,
                          onChangeInputMode: _onChangeInputMode,
                        ),
                        MessageInputField(
                          onTap: _onMessageFieldTapped,
                          focusNode: _focusNode,
                          controller: _textController,
                        ),
                        AttachmentAndCameraButton(
                          animation: _animation,
                          hideCameraButton: _hideCameraButton,
                        ),
                      ],
                    ),
                  ),
                ),
                SendAndMicInputButton(
                  animation: _animation,
                ),
              ],
            ),
          ),
          if (_inputMode == InputMode.EMOJI) Container(
            constraints: BoxConstraints(
              maxHeight: widget.keyboardHeight,
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
