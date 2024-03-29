import 'package:flutter/material.dart';
import 'package:whatsapp/screens/signup/signup.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Welcome To WhatsApp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Center(
                child: ClipRRect(
                  child: Image(
                    width: 280,
                    height: 280,
                    fit: BoxFit.cover,
                    image: AssetImage('lib/assets/imgs/welcome_background.png'),
                  ),
                  borderRadius: BorderRadius.circular(140),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Read our '),
                          TextSpan( text: 'Privacy Policy', style: TextStyle(color: Colors.blue)),
                          TextSpan( text: '. Tap "Agree and continue" to accept the '),
                          TextSpan( text: ' Terms of Service', style: TextStyle(color: Colors.blue)),
                        ],
                      )
                    ),
                    MaterialButton(
                      color: Color(0xff25d366),
                      child: Text(
                        'AGREE AND CONTINUE',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
