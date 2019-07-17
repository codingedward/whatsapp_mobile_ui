
import 'package:flutter/material.dart';

import '../chatlist/chatlist.dart' show ChatList;
import '../status/status.dart' show StatusList;
import '../calls/calls.dart' show CallList;
import '../camera/camera.dart' show CameraWidget;
import './home_tabs.dart' show HomeTabs;


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return HomeTabs(
      chatsWidget: ChatList(),
      statusWidget: StatusList(),
      callsWidget: CallList(),
      cameraWidget: CameraWidget(),
    );
  }
}