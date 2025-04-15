import 'package:flutter/material.dart';
const List<User> userList=[
  User( name: "Ali", imgUrl: "assets/user_images/img.png", number: 946310122, number2:1233456789, email: "example@gmail.com"),
  User( name: "Bohodir", imgUrl: "assets/user_images/img_1.jpg", number: 942222222, number2:1233456789, email: "example2@gmail.com"),
  User( name: "Sardor", imgUrl: "assets/user_images/img_1.png", number: 943333333, number2:1233456789, email: "example3@gmail.com"),
  User( name: "Davron", imgUrl: "assets/user_images/img_2.jpg", number: 944444444, number2:1233456789, email: "example4@gmail.com"),
  User( name: "Erkin", imgUrl: "assets/user_images/img_2.png", number: 945555555, number2:1233456789, email: "example5@gmail.com"),
  User( name: "Farrux", imgUrl: "assets/user_images/img_3.jpg", number: 946666666, number2:1233456789, email: "example6@gmail.com"),
  User( name: "Gayrat", imgUrl: "assets/user_images/img_3.png", number: 947777777, number2:1233456789, email: "example7@gmail.com"),
  User( name: "Hamid", imgUrl: "assets/user_images/img_4.png", number: 948888888, number2:1233456789, email: "example8@gmail.com"),
  User( name: "Ilhom", imgUrl: "assets/user_images/img_5.png", number: 949999999, number2:1233456789, email: "example9@gmail.com"),
  User( name: "Jalol", imgUrl: "assets/user_images/img_6.png", number: 940000000, number2:1233456789, email: "example10@gmail.com"),






];

class InheritedData extends InheritedWidget{
  final List<User> listUser;
  final User user;
const InheritedData( {super.key,required this.user ,required this.listUser, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedData oldWidget) {
//     return oldWidget.listUser!=listUser;
    return user!=oldWidget.user;
  }
  static InheritedData of(BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<InheritedData>()!;
  }
}
class User{
  final String name;
  final String imgUrl;
  final int  number ;
  final int  number2 ;
  final String  email ;
  const User( {required this.name,required  this.imgUrl,required  this.number,required  this.number2,required  this.email});
}