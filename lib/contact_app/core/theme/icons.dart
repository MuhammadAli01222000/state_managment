import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

sealed class AppIcons{
  static const edit=Icon(Icons.edit_note_sharp);
  static const alfa=Icon(Icons.abc_rounded,size: AppDimens.d24,);
  static const alfaNumber=Icon(Icons.numbers,size: AppDimens.d24,);
  static const delete=Icon(Icons.delete);
  static const sort=Icon(Icons.sort);
  static const call=Icon(Icons.call_outlined);
  static const back=Icon(Icons.arrow_back_ios);
  static const message=Icon(Icons.email_outlined);
  static const video=Icon(Icons.video_chat_outlined);
  static const telegram=Icon(Icons.send_rounded);
  static const email=Icon(Icons.alternate_email_outlined);
  static final add=Icon(Icons.add,color: AppColors.white,);
  static const search=Icon(Icons.search_rounded);
  static const person=Icon(Icons.person,size: AppDimens.d55,);
}