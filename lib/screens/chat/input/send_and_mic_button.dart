import 'package:flutter/material.dart';


class SendAndMicInputButton extends StatelessWidget {
  SendAndMicInputButton({
    Key key,
    @required this.animation,
  }) : assert(animation != null), 
       super(key: key);

  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xff075e54),
      ),
      child: AnimatedBuilder(
        animation: animation,
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
                scale: (1 - animation.value),
              ),
              Transform.scale(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  color: Colors.white,
                ),
                scale: animation.value,
              )
            ],
          );
        },
      )
    );
  }

}