import 'package:flutter/material.dart';
import 'widgets/app_navigator.dart' show AppNavigator;
import 'screens/chats.dart' show ChatList;

void main() {
  runApp(
    MaterialApp( 
      home: AppNavigator(
        onChatsTab: () {},
        onCallsTab: () {},
        onCameraTab: () {},
        onStatusTab: () {},
        chatsWidget: ChatList(),
        callsWidget: ChatList(),
        statusWidget: ChatList(),
        cameraWidget: ChatList(),
      )
    )
  );
}
