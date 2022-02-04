import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class CustomColors {
  static const kLightPinkColor = Color(0xffF3BBEC);
  static const kYellowColor = Color(0xffF3AA26);
  static const kCyanColor = Color(0xff0eaeb4);
  static const kPurpleColor = Color(0xff533DC6);
  static const kPrimaryColor = Color(0xff39439f);
  static const kBackgroundColor = Color(0xffF3F3F3);
  static const kLightColor = Color(0xffc4bbcc);
}

class CustomTextStyle {
  static const dayTabBarStyleInactive = TextStyle(
    color: CustomColors.kLightColor,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const dayTabBarStyleActive = TextStyle(
    color: CustomColors.kPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const metricTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
}

class IndicatorWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String iconPath;

  IndicatorWidget({this.color, this.title, this.subtitle, this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          height: 25,
          color: color,
        ),
        SizedBox(
          width: 40,
        ),
        Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: CustomColors.kLightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            )
          ],
        )
      ],
    );
  }
}
