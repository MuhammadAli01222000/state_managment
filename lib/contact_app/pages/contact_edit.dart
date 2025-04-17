import 'package:flutter/material.dart';
import 'package:state_managment/contact_app/model/user_model.dart';
import 'package:state_managment/contact_app/services/app_controller.dart';
import '../core/theme/colors.dart';
import '../core/theme/dimens.dart';
import '../core/theme/strings.dart';
import '../core/theme/text_fields.dart';
import '../core/theme/widgets.dart';

class Edit extends StatefulWidget {
  final User user;
  const Edit({super.key, required this.user});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final AppController appController = AppController();
  @override
  void initState() {
    super.initState();
   phoneController.text = widget.user.number.toString();
    phoneController2.text = widget.user.number2.toString();
    emailController.text = widget.user.email;
  }
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
        title: Row(
          children: [
            const Text('Back'),
            const SizedBox(width: AppDimens.d24),

            const Text("Edit Contact"),
            const SizedBox(width: AppDimens.d12),
            const Icon(Icons.edit),
          ],
        ),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.d24),
        child: Column(
          children: [
            SizedBox(
              width: AppDimens.d120,
              height: AppDimens.d120,
              child: Card(
                shape: CircleBorder(),
                child: ClipOval(
                  child: Image.asset(widget.user.imgUrl, fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.d24),

            Text(
              widget.user.name,
              style: TextStyle(
                fontSize: AppDimens.d24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppDimens.d100),
            AppDivider(),
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
            AppButtons(
              width: AppDimens.d120.toInt(),
              height: AppDimens.d40.toInt(),
              text: "Add",
              widget: widget,
              onTap: () {
                ///user edit
                final updatedUser = User(
                  name: widget.user.name,
                  imgUrl: widget.user.imgUrl,
                  number: int.tryParse(phoneController.text) ?? 0,
                  number2: int.tryParse(phoneController2.text) ?? 0,
                  email: emailController.text,
                );

                
                appController.updateUser(updatedUser);

                // Qaytish
                Navigator.pop(context, updatedUser);
              }, check: checkInput,
            ),
            const SizedBox(height: AppDimens.d24),
          ],
        ),
      ),
    );
  }
}
