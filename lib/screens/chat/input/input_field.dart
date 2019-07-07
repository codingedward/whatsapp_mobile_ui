import 'package:flutter/material.dart';

import 'emoji_support/emoji_text_field.dart';

class MessageInputField extends StatelessWidget {

  MessageInputField({
    Key key,
    this.onTap,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  final VoidCallback onTap;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: EmojiTextField(
        minLines: 1,
        maxLines: 6,
        onTap: onTap,
        autofocus: true,
        focusNode: focusNode,
        controller: controller,
        style: TextStyle(fontSize: 18),
        cursorColor: const Color(0xff075e54),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type a message',
          hintStyle: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

}