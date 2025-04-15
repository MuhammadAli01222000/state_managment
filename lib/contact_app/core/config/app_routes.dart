import 'package:flutter/material.dart';
import 'package:state_managment/contact_app/pages/contact_add.dart';
import 'package:state_managment/contact_app/pages/contact_edit.dart';
import 'package:state_managment/contact_app/pages/home.dart';

import '../../model/user_model.dart';

sealed class AppRoutes {
  static const home = "";
  static const edit = "edit";
  static const add = "add";

  static Map<String, WidgetBuilder> routes = {
    "home": (context) => Home(userList: []),
    "edit": (context) {
      final user = ModalRoute.of(context)!.settings.arguments as User;
      return Edit(user: user);
    },
    "add": (context) => const Add(),
  };
  static back(context) {
    Navigator.pop(context);
  }
}
