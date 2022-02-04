import 'package:flutter/material.dart';
import 'package:flutter_app_liquid/models/Lineas.dart';
import 'package:flutter_app_liquid/models/Liquidacion.dart';
import 'package:flutter_app_liquid/store/app_store.dart';
import 'package:flutter_app_liquid/store/liquidacion_store.dart';

import 'HomeLiquidacion.dart';

class HomePageLiquidacionView extends StatefulWidget {
  final Lineas list;
  HomePageLiquidacionView(this.list);
  @override
  _HomePageLiquidacionViewState createState() =>
      _HomePageLiquidacionViewState();
}

class _HomePageLiquidacionViewState extends State<HomePageLiquidacionView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   /*   appBar: AppBar(
        title: Text(widget.list.crNombre),
      ),*/
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /*Flexible(
                  child: ListView(
                    children: <Widget>[
                      ListTile(title: Text("Menu")),
                      Material(
                          type: MaterialType.transparency, //Makes it usable on any background color, thanks @IanSmith
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.indigoAccent, width: 3.0),
                              color: Colors.indigo[900],
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              //This keeps the splash effect within the circle
                              borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
                              onTap: ()=>null,
                              child: Padding(
                                padding:EdgeInsets.all(18.0),
                                child: Icon(
                                  Icons.message,
                                  size: 28.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                      ),

                    ],
                  ),
                ),*/
                Expanded(
                  flex: 1,
                  child: Container(
                    child: MyHomePageLiquidacion(
                      cobro: widget.list.crIdcobro,
                      title : widget.list.crNombre,
                      usuariolinea: widget.list.cuUsuario,
                    ),
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
