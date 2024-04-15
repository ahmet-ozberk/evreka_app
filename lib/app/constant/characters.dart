import 'package:evreka_app/app/constant/constants.dart';
import 'package:flutter/material.dart';

sealed class CharacterStyles {
  static const h3 = TextStyle(
    fontSize: 20,
    color: Color(0XFF172c49),
    fontWeight: FontWeight.w800,
  );

  static final h4 = TextStyle(
    fontSize: 16,
    color: Constants.color.darkGrey,
    fontWeight: FontWeight.w800,
  );

  static const t2 = TextStyle(
    fontSize: 20,
    color: Color(0XFF535a72),
    fontWeight: FontWeight.w400,
  );

  static const buttonText = TextStyle(
    fontSize: 20,
    color: Color(0XFFfbfcff),
    fontWeight: FontWeight.w700,
  );

  static final t1 = TextStyle(
    fontSize: 16,
    color: Constants.color.darkGrey,
    fontWeight: FontWeight.w400,
  );

  static final inputboxLabelDeactive = TextStyle(
    fontSize: 16,
    color: Constants.color.shadowColor,
    fontWeight: FontWeight.w400,
  );

  static final inputboxLabelFilled = TextStyle(
    fontSize: 12,
    color: Constants.color.shadowColor,
    fontWeight: FontWeight.w400,
  );

  static final inputboxLabelActive = TextStyle(
    fontSize: 12,
    color: Constants.color.yellow,
    fontWeight: FontWeight.w400,
  );

  static final inputboxLabelError = TextStyle(
    fontSize: 12,
    color: Constants.color.errorColor,
    fontWeight: FontWeight.w400,
  );
}
