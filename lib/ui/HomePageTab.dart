import 'package:flutter/material.dart';


class HomePageTab extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePageTab> {
  List<Map<String, dynamic>> _tabs = [];
  List<String> _views = [];

  @override
  void initState() {
    super.initState();
    this._addTab();
  }

  void _addTab() {
    setState(() {
      _tabs.add({
        'icon': Icons.star,
        'text': "Tab ${_tabs.length}",
      });
//      _views.add(Center(child: Text("Tab ${_tabs.length}'s view")));
      _views.add("Tab ${_tabs.length}'s view");
    });
  }

  void _removeTab() {
    setState(() {
      _tabs.removeLast();
      _views.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dynamic tabs"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh_outlined), onPressed: this._addTab),
            IconButton(icon: Icon(Icons.add), onPressed: this._addTab),
            IconButton(icon: Icon(Icons.remove), onPressed: this._removeTab),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs
                .map((tab) => Tab(
              icon: Icon(tab['icon']),
              text: "Tab ${_tabs.length}",
            ))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: _views
              .map((view) => Center(child: Text("Tab ${_tabs.length}'s view")))
              .toList(),
        ),
      ),
    );
  }
}