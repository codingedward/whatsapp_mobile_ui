import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsapp/screens/home/home.dart';

import '../../services/phone_verification_service.dart';

class PhoneVerification extends StatefulWidget {

  PhoneVerification({
    Key key, 
    @required this.phoneNumber
  }) : super(key: key);

  final String phoneNumber;

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {

  Duration _timeout;
  Stopwatch _stopwatch;
  String _timeCountdown;
  Timer _verificationTimer;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _timeout = Duration(minutes: 2);
    _stopwatch = Stopwatch()..start();
    _timeCountdown = _formatedTimeout();
    _textController = TextEditingController();
    _verifyPhoneNumber();
  }

  @override
  void dispose() {
    _textController.dispose();
    _verificationTimer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _onVerifySuccess(_) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Home())
    );
  }

  void _onVerifyFail(String message) {
    _verificationTimer?.cancel();
    _stopwatch.stop();
    _stopwatch.reset();
  }

  void _onVerifyTimeout(_) => null;

  Future<void> _verifyPhoneNumber() async {
    await PhoneVerificationService.instance.attemptAutoVerify(
      timeout: _timeout,
      phoneNumber: widget.phoneNumber,
      onFail: _onVerifyFail,
      onSuccess: _onVerifySuccess,
      onTimeout: _onVerifyTimeout, 
    );
    _verificationTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      int countdown = (_timeout.inSeconds - _stopwatch.elapsed.inSeconds);
      int minutes = countdown ~/ 60;
      int seconds = countdown % 60;
      setState(() {
        _timeCountdown = "$minutes:${seconds < 10 ? '0$seconds' : seconds}";
      });
      if (countdown <= 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _buildVerificationMessage(),
              SizedBox(
                width: 140,
                child: TextField(
                  maxLength: 6,
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 12,
                  ),
                  decoration: InputDecoration(
                    hintText: '______',
                    hintStyle: TextStyle(
                      fontSize: 22,
                      letterSpacing: 14,
                    )
                  ),
                  controller: _textController,
                  keyboardType: TextInputType.number,
                )
              ),
              SizedBox(height: 10,),
              Text(
                'Enter 6-digit code', 
                style: TextStyle(
                  color: 
                  Colors.black54, 
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height: 15,),
              _buildResendMessageTile(),
              Divider(color: Colors.black45,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendMessageTile() {
    return ListTile(
      leading: SizedBox(
        width: 40,
        child: Align(
          child: Icon(Icons.message, size: 18, color: Colors.grey,),
          alignment: Alignment.centerLeft,
        ),
      ),
      title: Text(
        'Resend SMS', 
        style: TextStyle(
          fontSize: 14, 
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        _timeCountdown,
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildVerificationMessage() {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Verify ${widget.phoneNumber}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff075e54),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 13),
              children: <TextSpan>[
                TextSpan(text: 'Waiting to automatically detect an SMS sent to '),
                TextSpan(text: '${widget.phoneNumber}. ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Wrong number?', style: TextStyle(color: Colors.lightBlue)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatedTimeout() {
    int countdown = _timeout.inSeconds - _stopwatch.elapsed.inSeconds;
    int minutes = countdown ~/ 60;
    int seconds = countdown % 60;
    return "$minutes:${seconds < 10 ? '0$seconds' : seconds}";
  }
}