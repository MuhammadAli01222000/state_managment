import 'package:flutter/material.dart';
import 'package:state_managment/contact_app/core/theme/colors.dart';
import 'package:state_managment/contact_app/core/theme/dimens.dart';
import 'package:state_managment/contact_app/core/theme/icons.dart';
import 'package:state_managment/contact_app/core/theme/strings.dart';
import 'package:state_managment/contact_app/services/app_controller.dart';

import '../core/theme/text_fields.dart';
import '../core/theme/widgets.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
final AppController appController=AppController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool checkInput = appController.checkInput(
      phoneController.text.length,
      phoneController2.text.length,
      emailController.text,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text('Back'),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.d24),
        child: Column(
          children: [
            UserIcons(),
            const SizedBox(height: AppDimens.d120),
            AppDivider(),
             AppTextField(hintText: AppStrings.number1, errorText: AppStrings.errorNumber, checkNumber: true, controller: phoneController,),
            const SizedBox(height: AppDimens.d24),

             AppTextField(hintText: AppStrings.number2, errorText: AppStrings.errorNumber, checkNumber: true, controller:phoneController2 ,),
            const SizedBox(height: AppDimens.d24),

             AppTextField(hintText: AppStrings.email, errorText: AppStrings.errorEmail, checkNumber: false, controller:emailController ,),
            const SizedBox(height: AppDimens.d24),
           const  Spacer(),
            AppButtons(width: AppDimens.d120.toInt(), height:AppDimens.d40.toInt(), text: "Add", widget: widget, onTap: (){Navigator.pop(context);}, check: checkInput,),
            const SizedBox(height: AppDimens.d24),

          ],
        ),
      ),
    );
  }
}
