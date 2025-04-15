import'package:flutter/material.dart';
import 'package:state_managment/contact_app/pages/contact_add.dart';
import 'package:state_managment/contact_app/pages/contact_edit.dart';
import 'package:state_managment/contact_app/pages/home.dart';
sealed class AppRoutes {
  static const home = "";
  static const edit = "/edit";
  static const add = "/add";

  static   Map<String, WidgetBuilder>  routes = {
    "home": (context) => Home(userList: []),
    "edit": (context) => const Edit(),
    "add": (context) => const Add(),
  };

}
