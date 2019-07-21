import 'package:flutter/material.dart';

class ConfirmPhoneNumberDialog extends StatelessWidget {

  ConfirmPhoneNumberDialog({
    Key key,
    @required this.phoneNumber,
    @required this.onOK,
  }) : super(key: key);

  final String phoneNumber;
  final VoidCallback onOK;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: 'We will be verifying the phone number:\n\n'),
                TextSpan(text: '$phoneNumber\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Is this OK, or would you like to edit the number?'),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text('EDIT'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: onOK,
              )
            ],
          )
        ],
      ),
    );
  }
}