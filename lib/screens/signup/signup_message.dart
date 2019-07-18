import 'package:flutter/material.dart';

class SignUpMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Verify your phone number',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff075e54),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Center(
          child: Text(
            'WhatsApp will send an SMS message (carrier charges may apply) to verify your phone number. '
            'Enter your country code and phone number:'
          ),
        ),
      ],
    );
  }
}
