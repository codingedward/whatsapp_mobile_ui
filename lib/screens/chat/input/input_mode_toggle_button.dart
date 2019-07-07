import 'package:flutter/material.dart';

enum InputMode { NONE, EMOJI, TEXT }

typedef void ChangeInputModeCallback(InputMode mode);

class InputModeToggleButton extends StatelessWidget {

  InputModeToggleButton({
    Key key,
    this.mode,
    this.onChangeInputMode
  }) : super(key: key);

  final InputMode mode;
  final ChangeInputModeCallback onChangeInputMode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onChangeInputMode(
          (mode == InputMode.EMOJI)
          ? InputMode.TEXT 
          : InputMode.EMOJI
        );
      },
      icon: Icon(
        (mode == InputMode.TEXT) ? Icons.keyboard : Icons.tag_faces, 
        color: Colors.black54,
      ),
    );
  }
}