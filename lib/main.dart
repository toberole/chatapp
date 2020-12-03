import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constant.dart';
import 'bean/Contact.dart';
import 'common/TLSizeFit.dart';
import 'db/DB.dart';
import 'page/LaunchPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  String defaultRouteName = window.defaultRouteName;
  print("defaultRouteName: $defaultRouteName");

  TLSizeFit.initialize();

  // if (Platform.isAndroid) {
  //   SystemUiOverlayStyle systemUiOverlayStyle =
  //       SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // }

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        ///这是设置状态栏的图标和字体的颜色
        ///Brightness.light  一般都是显示为白色
        ///Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  init();
  return runApp(LaunchPage());
}

void init() async {
  DB.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool b = prefs.getBool(KEY_INIT_CONTACT);
  print("KEY_INIT_CONTACT: $b");

  if (b == null || !b) {
    List<Contact> cs = [];
    Contact contact = new Contact();
    contact.name = "A";
    contact.desc = "A Hello";
    cs.add(contact);

    contact = new Contact();
    contact.name = "B";
    contact.desc = "B Hello";
    cs.add(contact);

    contact = new Contact();
    contact.name = "C";
    contact.desc = "C Hello";
    cs.add(contact);

    contact = new Contact();
    contact.name = "D";
    contact.desc = "D Hello";
    cs.add(contact);

    contact = new Contact();
    contact.name = "E";
    contact.desc = "E Hello";
    cs.add(contact);

    DB.insertContacts(cs);

    prefs.setBool(KEY_INIT_CONTACT, true);
  }
}
