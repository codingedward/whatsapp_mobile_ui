import 'package:flutter/material.dart';

import 'countries.dart';

typedef _SearchOnCloseCallback(Country country);

class CountrySearchDelegate extends SearchDelegate<Country> {
  CountrySearchDelegate({
    @required this.onClose,
    @required this.countries,
  });

  final Countries countries;
  final _SearchOnCloseCallback onClose;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed:() => query = ''
      )
    ];
  }

  @override
  void close(BuildContext context, Country country) {
    onClose(country);
    super.close(context, country);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context)  => null;

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty 
    ? countries.list 
    : countries.list.where((country) => country.name.toLowerCase().startsWith(query.toLowerCase())).toList();
    
    return ListView.builder(
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return InkWell(
          child: ListTile(
            onTap: () => close(context, suggestions[index]),
            leading: Text(
              suggestion.flag,
              style: TextStyle(fontSize: 23),
            ),
            title: RichText(
              text: TextSpan(
                text: suggestion.name.substring(0, query.length),
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    style: TextStyle(color: Colors.black54),
                    text: suggestion.name.substring(query.length)
                  )
                ],
              )
            ),
            trailing: Text(
              '+${suggestion.dial}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
          ),
        );
      },
      itemCount: suggestions.length,
    );
  }
}
