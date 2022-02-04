import 'package:flutter/material.dart';
import 'package:flutter_app_liquid/components/Animation/fade_animation.dart';
import 'package:flutter_app_liquid/data/chat_json.dart';
import 'package:flutter_app_liquid/helpers/Session.dart';
import 'package:flutter_app_liquid/models/Lineas.dart';
import 'package:flutter_app_liquid/models/SessionData.dart';
import 'package:flutter_app_liquid/providers/theme_provider.dart';
import 'package:flutter_app_liquid/store/app_store.dart';
import 'package:flutter_app_liquid/theme/colors.dart';
import 'package:flutter_app_liquid/ui/HomePageLiquidacionView.dart';
import 'package:flutter_app_liquid/ui/login_page.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'navigator.dart';

class HomeLineasPage extends StatefulWidget {
  //final SessionData session;
  HomeLineasPage();
  @override
  _HomeLineasPageState createState() => _HomeLineasPageState();
}

class _HomeLineasPageState extends State<HomeLineasPage> {
  bool _loading = true;
  bool mode_night = false;
  SessionData sessionData;
  List<Lineas> list = [];

  GetListLineas() async {
    try {
      var result = await liquidacionStore.DataLineasForTipoTercero();
      print('result');
      print(result);
      setState(() {
        list = result;
        _loading = false;
      });
      print(list.length);
    } on Exception catch (_) {
      print('never reached');
    }
  }

  @override
  void initState() {
    GetSession();
    // super.initState();

    //Future.delayed(Duration(milliseconds: 100)).then((_) { });

    GetListLineas();
  }

  GetSession() async {
    SessionData sessdata = await Session.getSession();
    setState(() {
      sessionData = sessdata;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          elevation: 2,
          centerTitle: false,
          titleSpacing: 0.0,
          // titleSpacing: 1,
          /*leading: GestureDetector(
            onTap: () { /* Write listener code here */ },
            child: Icon(
              Icons.menu,  // add custom icons also
            ),
          ),*/
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              onPressed: () async {
                await Session.Clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          title: ListTile(
            dense: true,
            leading: Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/login_avatar.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(sessionData?.us_usuario.toString(),
                style: theme.textTheme.headline4, textAlign: TextAlign.left),
            subtitle: Text(
              sessionData?.te_nombres.toString(),
              style: theme.textTheme.subtitle2,
            ),
            trailing: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: mode_night
                    ? kBackgroundDarkColorAppBar
                    : kBackgroundLightColorAppBar,
              ),
              child: IconButton(
                alignment: Alignment.center,
                padding: EdgeInsets.all(1),
                icon: Icon(
                  mode_night ? Icons.brightness_3 : Icons.brightness_4,
                  color: Colors.white,
                  size: 24.0,
                ),
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme();
                  setState(() {
                    mode_night = !mode_night;
                  });
                },
              ),
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(right: 0, left: 0, bottom: 0, top: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: theme.backgroundColor),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  liquidacionStore.loading
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 40.0.h, horizontal: 3.0.h),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.buttonColor),
                              ),
                            ),
                            color: Colors.white.withOpacity(0.8),
                          ))
                      : getBody(context)
                ]))));
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 2,
      backgroundColor: Colors.pinkAccent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                  //<------------------------- InkWell
                  splashColor: Colors.white30,
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacement(createRoute(LoginPage()));
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: black.withOpacity(0.1)),
                    child: Icon(
                      Entypo.power_plug,
                      color: primary,
                      size: 28,
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: black.withOpacity(0.1)),
                child: Icon(
                  Feather.search,
                  color: Colors.white,
                  size: 23,
                ),
              )
            ],
          ),
          Text(
            "Lineas",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: black.withOpacity(0.1)),
                child: Icon(
                  Feather.user_plus,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: black.withOpacity(0.1)),
                child: Icon(
                  AntDesign.home,
                  color: Colors.white,
                  size: 20,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getBody3() {
    return new Text("Hola");
  }

  Widget getBody(BuildContext context) {
    final theme = Theme.of(context);
    return StaggeredGridView.countBuilder(
      itemCount: list.length,
      crossAxisCount: 1,
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      itemBuilder: (context, index) {
        var product = list[index];
        return FadeInAnimation(index,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50.0.w,
                        child: Row(
                          children: [
                            Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(top: 0),
                                child: new CircleAvatar(
                                  backgroundColor:
                                      int.parse(product.hoyliquidado) == 1
                                          ? Colors.teal
                                          : Colors.pink,
                                  foregroundColor: Colors.white,
                                  // backgroundImage:
                                  // new NetworkImage("https://content-static.upwork.com/uploads/2014/10/01073427/profilephoto1.jpg"),
                                  child: new Text(
                                    product.crNombre.substring(0, 1),
                                    textAlign: TextAlign.right,
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),

                                  radius: 20.0,
                                )),
                            /* Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(chat_data[1]['img']),
                                      fit: BoxFit.cover)),
                            ),*/
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 13),
                              width: 30.0
                                  .w, //ScreenUtil().setWidth(170), //(size.width - 75) * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.crNombre,
                                    style: theme.textTheme.subtitle1,
                                    /*style: TextStyle(
                                        fontSize: ScreenUtil().setSp(25),
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400
                                    ),*/
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Max ${product.crCompraMax}',
                                    style: theme.textTheme.subtitle2,
                                    /*style: TextStyle(
                                        fontSize: ScreenUtil().setSp(23),
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w400
                                    ),*/
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${product.crEmail}",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 30.0.w, //(size.width - 100) * 0.32,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    createRoute(
                                        HomePageLiquidacionView(product)),
                                  );
                                },
                                child: Container(
                                  //Navigator.of(context).pushNamed(CategoryDetailScreen.routeName);
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: blue)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, bottom: 4, left: 12, top: 4),
                                    child: Row(
                                      children: [
                                        Icon(Icons.play_arrow,
                                            size: 10.0.sp, color: blue),
                                        SizedBox(width: 5),
                                        Text(
                                          "Liquidar",
                                          style: TextStyle(
                                              color: blue, fontSize: 9.0.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: purple)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 12, bottom: 4, left: 12, top: 4),
                                child: Row(
                                  children: [
                                    Icon(Icons.edit,
                                        size: 10.0.sp, color: purple),
                                    SizedBox(width: 5),
                                    Text(
                                      "Editar",
                                      style: TextStyle(
                                          color: purple, fontSize: 9.0.sp),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            /*

                                  Icon(
                                    AntDesign.close,
                                    size: 16,
                                    color: darkGrey.withOpacity(0.7),
                                  )*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Divider()
              ],
            ));
      },
    );
    /* return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.list[index].crNombre),
        );
      },
    );*/
  }

  Widget getBody2() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    height: 1,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Lineas totales (${list.length})",
                  style: TextStyle(color: blue),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    height: 1,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
                children: List.generate(list.length, (index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: (size.width - 10) * 0.68,
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            chat_data[index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: ScreenUtil()
                                    .setWidth(170), //(size.width - 75) * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[index].crNombre,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(25),
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Max ${list[index].crCompraMax}',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(23),
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${list[index].crEmail}",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenUtil()
                              .setWidth(200), //(size.width - 100) * 0.32,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      createRoute(
                                          HomePageLiquidacionView(list[index])),
                                    );
                                  },
                                  child: Container(
                                    //Navigator.of(context).pushNamed(CategoryDetailScreen.routeName);
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: blue)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12,
                                          bottom: 4,
                                          left: 12,
                                          top: 4),
                                      child: Row(
                                        children: [
                                          Icon(Icons.play_arrow,
                                              size: 18, color: blue),
                                          SizedBox(width: 5),
                                          Text(
                                            "Liquidar",
                                            style: TextStyle(
                                                color: blue,
                                                fontSize:
                                                    ScreenUtil().setSp(23)),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: purple)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12, bottom: 4, left: 12, top: 4),
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, size: 18, color: purple),
                                      SizedBox(width: 5),
                                      Text(
                                        "Editar",
                                        style: TextStyle(
                                            color: purple,
                                            fontSize: ScreenUtil().setSp(23)),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              /*

                                  Icon(
                                    AntDesign.close,
                                    size: 16,
                                    color: darkGrey.withOpacity(0.7),
                                  )*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider()
                ],
              );
            })),
          ],
        ),
      ),
    );
  }
}
