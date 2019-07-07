import 'package:flutter/material.dart';


class SendAndMicInputButton extends StatelessWidget {
  
  SendAndMicInputButton(
    this._animation, {
    Key key,
  }) : super(key: key);

  final Animation _animation;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

}