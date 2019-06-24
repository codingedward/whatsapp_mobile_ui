import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'widgets/app_navigator.dart' show AppNavigator;
import 'screens/chats.dart' show ChatList;
import 'screens/status.dart' show StatusList;
import 'screens/calls.dart' show CallList;
import 'screens/camera.dart' show CameraWidget;

Future<void> main() async {
  final cameras = await availableCameras();
  runApp(
    MaterialApp( 
      home: AppNavigator(
        chatsWidget: ChatList(),
        callsWidget: CallList(),
        statusWidget: StatusList(),
        cameraWidget: CameraWidget(camera: cameras.first),
      ),
    )
  );
}
