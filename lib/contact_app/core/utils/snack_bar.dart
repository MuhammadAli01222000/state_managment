import 'package:flutter/material.dart';

import '../../model/user_model.dart';

void showInfoSnackBar(
  User? user, {
  required BuildContext context,
  required String message,
}) {
  final snackBar = SnackBar(
    action: SnackBarAction(
      label: "Cancel",
      onPressed: () {
        if (user == null) return userList.add(user!);
        print("${user.name} qoshildi");
      },
    ),
    content: Row(
      children: [
        Icon(Icons.info, color: Colors.white),
        SizedBox(width: 8),
        Expanded(child: Text(message)),
      ],
    ),
    backgroundColor: Colors.blueAccent,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    duration: Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
