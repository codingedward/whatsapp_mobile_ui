import 'package:flutter/material.dart';

class EmojiRichText extends StatelessWidget{

  const EmojiRichText({
    Key key,
    @required this.text,
    this.textAlign = TextAlign.start,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.emojiFontFamily = 'EmojiOne',
    this.fontSize = 15,
    this.color = Colors.black87,
  }) : assert(text != null),
       assert(textAlign != null),
       assert(softWrap != null),
       assert(overflow != null),
       assert(textScaleFactor != null),
       assert(maxLines == null || maxLines > 0),
       super(key: key);

  final bool softWrap;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final String text;
  final double textScaleFactor;
  final int maxLines;
  final Locale locale;
  final StrutStyle strutStyle;
  final String emojiFontFamily;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      text: _buildText(this.text),
    );
  }

  TextSpan _buildText(String text) {
    final children = <TextSpan>[]; 
    final runes = text.runes;

    for (int i = 0; i < runes.length; /* empty */ ) {
      int current = runes.elementAt(i);
      final isEmoji = current > 255;
      final shouldBreak = isEmoji
        ? (x) => x <= 255 
        : (x) => x > 255;

      final chunk = <int>[];
      while (! shouldBreak(current)) {
        chunk.add(current);
        if (++i >= runes.length) break;
        current = runes.elementAt(i);
      }
      children.add(
        TextSpan(
          text: String.fromCharCodes(chunk),
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontFamily: isEmoji ? emojiFontFamily : null,
          ),
        ),
      );
    }

    return TextSpan(children: children);
  } 
}