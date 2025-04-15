import 'package:flutter/material.dart';
import 'package:state_managment/app.dart';

import '../model/user_model.dart';

class ContactController extends ChangeNotifier{
final  List<User>userList;
late  List<User>_items=userList;
List<User> get search =>_items;
List<User> get filter =>_items;

 ContactController({required this.userList});
}



class AppController{
 bool checkInput(int number1,int number2,String email){
  final String input1 = number1.toString();
  final String input2 = number2.toString();
  if(input2.length >=13&&input1.length >=13 && email.contains("@") && email.length>11 ) return true;
  return false;
 }

static void edit(String email, int number, int number2, int index) {
  userList[index] = userList[index].copyWith(
   number: number,
   number2: number2,
   email: email,
  );
 }


}
