import 'package:flutter/material.dart';
import 'package:state_managment/contact_app/core/theme/strings.dart';
import 'package:state_managment/contact_app/pages/search_page.dart';

import '../../model/user_model.dart';
import '../config/app_routes.dart';
import 'colors.dart';
import 'dimens.dart';
import 'icons.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.add);
      },
      backgroundColor: AppColors.blue,
      shape: CircleBorder(),
      child: AppIcons.add,
    );
  }
}

class SliverContact extends StatelessWidget {
  const SliverContact({
    super.key,
    required this.size,
    required this.controller,
  });

  final Size size;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.d120,
      width: size.width - 2,
      child: CustomScrollView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Row(
                children: [
                  for (var o in userList)
                    Column(
                      children: [
                        SizedBox(
                          height: AppDimens.d100,
                          width: AppDimens.d100,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.edit,
                                arguments: o,
                              );
                            },
                            child: Card(
                              color: AppColors.black,
                              child: Image.asset(o.imgUrl, fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            o.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimens.d16,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
final void Function()? onTap;
  const SearchWidget({
    super.key,
    required this.size,
    required this.controllerText, this.onTap,
  });

  final Size size;
  final TextEditingController controllerText;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: AppDimens.d55,
      width: widget.size.width - 20,
      child: Card(
        color: AppColors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: TextField(
            onTap:widget.onTap != null? (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SearchPage()),
    );
            }:(){},
            controller: widget.controllerText,
            maxLength: 40,
            decoration: InputDecoration(
              counterText: "",
              hintText: AppStrings.search,
              hintStyle: TextStyle(color: AppColors.grey2),
              suffixIcon: IconButton(
                onPressed: () {
                  for (var o in userList )
                    if(o.name.toLowerCase()==widget.controllerText.text.toLowerCase()) Text("bor");

                  Text("yoq");

                },

                ///metod
                icon: AppIcons.search,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppDimens.d16,
                vertical: AppDimens.d12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider();
  }
}

class AppButtons extends StatelessWidget {
  final int width;
  final int height;
  final String text;
  final Widget widget;
  final void Function() onTap;
  final bool check;
  const AppButtons({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.widget,
    required this.onTap,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      child: Center(
        child: Text(text, style: TextStyle(color: AppColors.white)),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.blue),
      ),
    );
  }
}

class UserIcons extends StatelessWidget {
  const UserIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.d120,
      height: AppDimens.d120,
      child: Card(
        shape: CircleBorder(),
        child: AppIcons.person,
        color: AppColors.pink,
      ),
    );
  }
}
