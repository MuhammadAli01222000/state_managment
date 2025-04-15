import 'package:flutter/material.dart';
import 'package:state_managment/contact_app/core/config/app_routes.dart';
import 'package:state_managment/contact_app/model/user_model.dart';
import 'contact_app/pages/home.dart';

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InheritedData(
      listUser: userList,
      user: User(
        name: "Ali",
        imgUrl: "assets/user_images/img.png",
        number: 946310122,
        number2: 1233456789,
        email: "example@gmail.com",
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
routes: AppRoutes.routes,
        home: Home(userList: userList),
      ),
    );
  }
}
