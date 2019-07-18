import 'dart:math' as math;

import 'package:flutter/material.dart';

class AttachmentAndCameraButton extends StatelessWidget {
  const AttachmentAndCameraButton({
    Key key,
    @required this.animation,
    @required this.hideCameraButton,
  })  : assert(animation != null),
        assert(hideCameraButton != null),
        super(key: key);

  final Animation animation;
  final bool hideCameraButton;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        final offset = Offset(animation.value * 50.0, 0);
        final attachButton = Transform.rotate(
          angle: -math.pi / 4,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.attach_file, color: Colors.black54),
          ),
        );
        return Row(
          children: <Widget>[
            hideCameraButton
                ? Transform.translate(
                    offset: offset,
                    child: attachButton,
                  )
                : attachButton,
            if (hideCameraButton)
              Opacity(
                opacity: hideCameraButton ? 1 : animation.value,
                child: Transform.translate(
                  offset: offset,
                  child: child,
                ),
              ),
          ],
        );
      },
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.photo_camera,
          color: Colors.black54,
        ),
      ),
    );
  }
}
