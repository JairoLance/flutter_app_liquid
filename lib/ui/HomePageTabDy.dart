import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_liquid/components/fab_bottom_app_bar.dart';
import 'package:flutter_app_liquid/ui/HomeLiquidacion.dart';
//https://github.com/flutter/flutter/issues/20292
//https://benjaken.gitbook.io/flutter-vant-kit/display-components/skeleton
class HomePageTabDy extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePageTabDy>
    with TickerProviderStateMixin {
  TabController _tc;

  List<Map<String, dynamic>> _tabs = [];
  List<String> _views = [];

  @override
  void initState() {
    super.initState();
    this._addTab();
  }

  TabController _makeNewTabController() => TabController(
        vsync: this,
        length: _tabs.length,
        initialIndex: _tabs.length - 1,
      );

  void _addTab() {
    setState(() {
      _tabs.add({
        'icon': Icons.account_balance_wallet,
        'text': "Linea ${_tabs.length + 1}", // + 1 here.
      });
      _views.add("Linea ${_tabs.length}'s view");
      _tc = _makeNewTabController();
    });
  }

  void _removeTab() {
    setState(() {
      _tabs.removeLast();
      _views.removeLast();
      _tc = _makeNewTabController();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liquidaciones"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh_outlined), onPressed: this._addTab),
          IconButton(icon: Icon(Icons.add), onPressed: this._addTab),
          IconButton(icon: Icon(Icons.remove), onPressed: this._removeTab),
        ],
        bottom: TabBar(
          controller: _tc,
          isScrollable: true,
          tabs: _tabs
              .map((tab) => Tab(
                    icon: Icon(tab['icon']),
                    text: tab['text'], // use the tab parameter here
                  ))
              .toList(),
        ),
      ),
      /*body: TabBarView(
        key: Key(Random().nextDouble().toString()),
        controller: _tc,
        children: _views
            .map((view) => Center(
                    child: MyHomePageLiquidacion(
                  title: "${view}",
                )))
            .toList(), // use the view parameter here
      ),*/

    );
  }
}
//.map((view) => Center(child: MyHomePageLiquidacion( title: "Linea ${_tabs.length}'s view", )))
