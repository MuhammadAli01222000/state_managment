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