import 'package:flutter/material.dart';
void showInfoSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
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
