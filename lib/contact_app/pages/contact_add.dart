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
  final AppController appController = AppController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final ValueNotifier<bool> showButton = ValueNotifier(false);
  void _show() {
    final show =
        nameController.text.isNotEmpty &&
        phoneController2.text.isNotEmpty &&
        phoneController2.text.isNotEmpty;
    showButton.value = show;
  }

  @override
  void initState() {
    super.initState();

    ///listin qilish uchun
    nameController.addListener(_show);
    phoneController.addListener(_show);
    phoneController2.addListener(_show);
    emailController.addListener(_show);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    phoneController2.dispose();
    emailController.dispose();
    showButton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

            AppTextField(
              hintText: AppStrings.name,
              errorText: 'Minimum 3  letter',
              checkNumber: false,
              controller: nameController,
            ),
            const SizedBox(height: AppDimens.d24),
            AppTextField(
              hintText: AppStrings.number1,
              errorText: AppStrings.errorNumber,
              checkNumber: true,
              controller: phoneController,
            ),
            const SizedBox(height: AppDimens.d24),

            AppTextField(
              hintText: AppStrings.number2,
              errorText: AppStrings.errorNumber,
              checkNumber: true,
              controller: phoneController2,
            ),
            const SizedBox(height: AppDimens.d24),

            AppTextField(
              hintText: AppStrings.email,
              errorText: AppStrings.errorEmail,
              checkNumber: false,
              controller: emailController,
            ),
            const SizedBox(height: AppDimens.d24),
            const Spacer(),
            ValueListenableBuilder<bool>(
              valueListenable: showButton,
              builder: (context, visible, child) {
                return visible
                    ? AppButtons(
                      width: 280,
                      height: 50,
                      text: "Add Contact",
                      widget: widget,
                      onTap: () {
                        appController.add(
                          nameController.text,
                          emailController.text,
                          int.parse(phoneController.text),
                          int.parse(phoneController2.text),
                          'assets/user_images/img_7.png',
                        );
                        Navigator.pop(context);
                      },
                      check: false,
                    )
                    : IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                      icon: AppIcons.back,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
