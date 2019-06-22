import 'package:flutter/material.dart';
import 'package:sliver_scaffold/sliver_scaffold.dart';


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
    final actions = this._buildActions(context);
    final tabs = this._buildTabs(MediaQuery.of(context).size);

    return DefaultTabController(
      initialIndex: 1,
      length : tabs.length,
      child: SliverScaffold(
        sliverAppBar: SliverAppBar(
          title: const Text('WhatsApp'),
          pinned: true,
          floating: true,
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
      Hero(
        tag: 'search',
        child: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          },
          tooltip: 'Search',
        ),
      ),
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
        tooltip: 'More options',
      )
    ];

  }
}

class DataSearch extends SearchDelegate<String> {

  final cities = [
    'Hi',
    'There',
    'Hi',
    'There',
    'Hi',
    'There',
  ];

  final recentCities = [
    'There',
    'Hi',
    'Friend',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentCities : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) =>  ListTile(
        leading: Icon(Icons.location_city),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
  
}