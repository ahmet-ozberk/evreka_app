import 'package:flutter/widgets.dart';

sealed class Constants {
  static final color = _ConstantsColor._();
  static final string = _ConstantsString._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context =>
      navigatorKey.currentState!.overlay!.context;

  static const String apiKey = "AIzaSyAdOOrPRv8_V6ZoUajaJCA12SIlJFjTLRY";
}

class _ConstantsColor {
  _ConstantsColor._();

  final Color errorColor = const Color(0XFFfc3131);
  final Color green = const Color(0XFF3ba935);
  final Color shadowGreen = const Color(0XFF72c875);
  final Color yellow = const Color(0XFFe9cf30);
  final Color darkGrey = const Color(0XFF535a72);
  final Color shadowColor = const Color(0XFFBBBBBB);
  final Color borderColor = const Color(0XFFe1e1e1);
  final Color darkBlue = const Color(0XFF172c49);
  final Color lightColor = const Color(0XFFfbfcff);
  final Color scaffoldBackgroundColor = const Color(0XFFECECEC);
}

class _ConstantsString {
  _ConstantsString._();

  final String appName = "Evreka App";
  final String loginInfo = "Please enter your user name and password.";
  final String username = "Username";
  final String password = "Password";
  final String obscureCharacter = "*";
  final String login = "LOGIN";
  final String changeMarkerLocationInfo = "Please select a location from the map for your bin to be relocated. You can select a location by tapping on the map.";
}
