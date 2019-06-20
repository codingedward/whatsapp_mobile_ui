import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp( home: MyApp()));
}

List<Widget> makeWidgets(double width) {
  return <Widget>[
    SizedBox(child: Tab(icon: Icon(Icons.camera_alt,), ), width: 30),
    SizedBox(child: Tab(text: 'CHATS',), width: width),
    SizedBox(child: Tab(text: 'STATUS',), width: width),
    SizedBox(child: Tab(text: 'CALLS',), width: width),
  ];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = (MediaQuery.of(context).size.width - 170) / 3;
    var tabs = makeWidgets(size);

    return DefaultTabController(
        length : tabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff075e54),
            title: const Text('WhatsApp'),
            actions: <Widget>[
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
            ],
            bottom: TabBar(
              tabs:  tabs,
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: tabs.map((Widget tab) {
              return Card(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('hi', textScaleFactor: 5,),
                    ]
                  )
                )
              );
            }).toList(),
          ),
        ),
      );
  }
}
