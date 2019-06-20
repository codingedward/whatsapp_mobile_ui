import 'package:flutter/material.dart';

class AppNavigator extends StatelessWidget {

  const AppNavigator({
    Key key,
    @required this.onCameraTab,
    @required this.onStatusTab,
    @required this.onChatsTab,
    @required this.onCallsTab,
    @required this.cameraWidget,
    @required this.statusWidget,
    @required this.chatsWidget,
    @required this.callsWidget,
  }) : super(key: key);

  final Widget chatsWidget;
  final Widget cameraWidget;
  final Widget statusWidget;
  final Widget callsWidget;
  final VoidCallback onCameraTab;
  final VoidCallback onStatusTab;
  final VoidCallback onChatsTab;
  final VoidCallback onCallsTab;

  @override
  Widget build(BuildContext context) {
    final actions = this._buildActions();
    final tabs = this._buildTabs(MediaQuery.of(context).size);
    return DefaultTabController(
      initialIndex: 1,
      length : tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp'),
          actions: actions,
          bottom: TabBar(
            tabs: tabs, 
            isScrollable: true,
            indicatorColor: Colors.white,
          ),
          backgroundColor: Color(0xff075e54),
        ),
        body: TabBarView(
          children: <Widget>[
            cameraWidget,
            chatsWidget,
            statusWidget,
            callsWidget,
          ],
        ),
      ),
    );
  }


  List<Widget> _buildTabs(Size deviceSize) {
    var width = (deviceSize.width - 170) / 3;
    return <Widget>[
      SizedBox(child: Tab(icon: Icon(Icons.camera_alt)), width: 30),
      SizedBox(child: Tab(text: 'CHATS',), width: width),
      SizedBox(child: Tab(text: 'STATUS',), width: width),
      SizedBox(child: Tab(text: 'CALLS',), width: width),
    ];
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
        tooltip: 'Search',
      ),
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
        tooltip: 'More options',
      )
    ];

  }
}