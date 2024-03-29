import 'dart:async';

import 'package:flutter/material.dart';

import '../calls/calls.dart';
import '../camera/camera.dart';
import '../chatlist/chatlist.dart';
import '../status/status.dart';

class Home extends StatefulWidget {
  final callList = CallList();
  final chatList = ChatList();
  final statusList = StatusList();
  final cameraWidget = CameraWidget();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin {

  bool _pinned = true;
  bool _camera = false;
  Timer _cameraTimer;
  TabController _tabController;
  bool _disableScrolling = false;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 1, vsync: this, length: 4);
    _tabController.animation.addListener(_handleChangeToCameraTab);
    _scrollController = ScrollController();
    _scrollController.addListener(_disableScrollingOnCameraTab);
  }

  void _disableScrollingOnCameraTab() {
    if (_disableScrolling) {
      // avoid infinite loop calls...
      _scrollController.removeListener(_disableScrollingOnCameraTab);
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      _scrollController.addListener(_disableScrollingOnCameraTab);
    }
  }

  void _handleChangeToCameraTab() {
    final value = _tabController.animation.value;
    if (value < 1) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent * (1.0 - value)
      );
    }

    setState(() {
      _pinned = value >= 1.0; // animating to camera tab
      _disableScrolling = value == 0.0; // camera tab
    });

    // We have to use a timer since the camera takes time to get 
    // initialized and can give a slow feel...
    _cameraTimer?.cancel();
    _cameraTimer = Timer(Duration(milliseconds: 100), () => setState(() {
      _camera = value == 0;
    }));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _cameraTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actions = this._buildActions(context);
    final tabs = this._buildTabs(MediaQuery.of(context).size);

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, inner) {
          return <Widget>[
            SliverAppBar(
              title: const Text('WhatsApp'),
              pinned: _pinned,
              floating: true,
              actions: actions,
              bottom: TabBar(
                tabs: tabs, 
                isScrollable: true,
                indicatorColor: Colors.white,
                controller: _tabController,
              ),
              backgroundColor: Color(0xff075e54),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _camera ? widget.cameraWidget : Container(
              decoration: BoxDecoration(
                color: Colors.black
              ),
            ),
            widget.chatList,
            widget.statusList,
            widget.callList,
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTabs(Size deviceSize) {
    var width = (deviceSize.width - 150) / 3;
    return <Widget>[
      const SizedBox(child: Tab(icon: Icon(Icons.camera_alt)), width: 22),
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