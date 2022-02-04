import 'package:flutter/material.dart';
import 'package:flutter_app_liquid/providers/theme_provider.dart';
import 'package:flutter_app_liquid/splash.dart';
import 'package:flutter_app_liquid/theme/theme.dart';
import 'package:flutter_app_liquid/ui/login_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer_util.dart';
import 'package:workmanager/workmanager.dart';

const task1 = "simpleTask Worked";

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    print("it's doing the task");
    switch (task) {
      case task1:
        print(task1);
        break;
      case Workmanager.iOSBackgroundTask:
        print("iOS background fetch delegate ran");
        break;
    }
    return Future.value(true);
  });
}

void main() {
  Workmanager.initialize(callbackDispatcher);
  Workmanager.registerPeriodicTask(
    "1",
    task1, //This is the value that will be returned in the callbackDispatcher
    initialDelay: Duration(minutes: 1),
    frequency: Duration(seconds: 10),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, theme, snapshot) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              //return OrientationBuilder
              builder: (context, orientation) {
                //initialize SizerUtil()
                SizerUtil()
                    .init(constraints, orientation); //initialize SizerUtil
                return MaterialApp(
                  title: 'Liquidacion',
                  debugShowCheckedModeBanner: false,
                  theme: themeData(context),
                  darkTheme: darkThemeData(context),
                  themeMode:
                      theme.isLightTheme ? ThemeMode.dark : ThemeMode.light,
                  home: SplashPage(),
                );
              },
            );
          },
        );
      }
          /*return MaterialApp(
              title: 'Doctor Consultant',
              debugShowCheckedModeBanner: false,
              theme: themeData(context),
              darkTheme: darkThemeData(context),
              themeMode: theme.isLightTheme ?  ThemeMode.dark:ThemeMode.light ,
              home: LoginPage(),
            );
          }*/

          ),
    );
  }
}
/*
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: themeData(context),
        darkTheme: darkThemeData(context),
        themeMode: theme.isLightTheme ?  ThemeMode.dark:ThemeMode.light ,
        /*theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.amber,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),*/
        home: LoginPage());
  }
}*/
