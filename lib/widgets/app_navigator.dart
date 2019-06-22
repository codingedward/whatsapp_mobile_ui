import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sliver_scaffold/sliver_scaffold.dart';


class AppNavigator extends StatefulWidget {
  const AppNavigator({
    Key key,
    @required this.cameraWidget,
    @required this.statusWidget,
    @required this.chatsWidget,
    @required this.callsWidget,
  }) : super(key: key);

  final Widget chatsWidget;
  final Widget cameraWidget;
  final Widget statusWidget;
  final Widget callsWidget;

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator>  with SingleTickerProviderStateMixin {

  bool _appBarShown = true;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex: 1, vsync: this, length: 4);
    _controller.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {
      _appBarShown = !_controller.indexIsChanging && _controller.index != 0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actions = this._buildActions(context);
    final tabs = this._buildTabs(MediaQuery.of(context).size);

    return SliverScaffold(
      topRadius: 0,
      sliverAppBar: SliverAppBar(
        title: const Text('WhatsApp'),
        pinned: _appBarShown,
        floating: _appBarShown,
        actions: actions,
        bottom: TabBar(
          tabs: tabs, 
          isScrollable: true,
          indicatorColor: Colors.white,
          controller: _controller,
        ),
        backgroundColor: Color(0xff075e54),
      ),
      body: TabBarView(
        controller: _controller,
        dragStartBehavior: DragStartBehavior.down,
        children: <Widget>[
          widget.cameraWidget,
          widget.chatsWidget,
          widget.statusWidget,
          widget.callsWidget,
        ],
      ),
    );
  }

  List<Widget> _buildTabs(Size deviceSize) {
    var width = (deviceSize.width - 150) / 3;
    return <Widget>[
      SizedBox(child: Tab(icon: Icon(Icons.camera_alt)), width: 22),
      SizedBox(child: Tab(text: 'CHATS',), width: width),
      SizedBox(child: Tab(text: 'STATUS',), width: width),
      SizedBox(child: Tab(text: 'CALLS',), width: width),
    ];
  }

  List<Widget> _buildActions(BuildContext context) {
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
