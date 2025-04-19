import 'package:state_managment/contact_app/model/user_model.dart';

class AppServices{
  static bool search(String? name){
    if(name==null || name.isEmpty ){
      return false;
    }
    for (var o in userList) {
      if(o.name.toLowerCase()==name.toLowerCase())return true;
    }
  return false;
  }

}