import 'package:flutter/material.dart';

class InvalidPhoneNumberDialog extends StatelessWidget {

  InvalidPhoneNumberDialog({
    Key key,
    @required this.countryName,
  }) : super(key: key);

  final String countryName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Invalid format'),
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      content:RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(text: 'The phone number provided is invalid for: $countryName\n\n'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}