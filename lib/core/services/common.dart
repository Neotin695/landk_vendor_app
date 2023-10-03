import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common {
  //static LangSerivce langSerivce = LangSerivce();
  static late SharedPreferences prefs;
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
}
