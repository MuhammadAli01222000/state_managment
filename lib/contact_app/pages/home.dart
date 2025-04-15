import 'package:flutter/material.dart';
import 'package:state_managment/contact_app/core/theme/colors.dart';
import 'package:state_managment/contact_app/core/theme/dimens.dart';
import 'package:state_managment/contact_app/core/theme/icons.dart';
import 'package:state_managment/contact_app/core/theme/strings.dart';
import 'package:state_managment/contact_app/model/user_model.dart';

import '../core/config/app_routes.dart';
import '../core/theme/widgets.dart';

class Home extends StatefulWidget {
  final List<User> userList;
  const Home({super.key, required this.userList});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controllerText = TextEditingController();
  final controller = ScrollController();
int index=0;
  @override
  void dispose() {
    controllerText.dispose();
    controller.dispose();
    super.dispose();
  }
  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    if (widget.userList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(AppStrings.contacts),
        ),
        backgroundColor: AppColors.white,
        body: Center(child: AddButton()),
        floatingActionButton: const AddButton(),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(widget.userList[0].imgUrl, () {}),
      backgroundColor: AppColors.white,
      floatingActionButton: const AddButton(),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.d10),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              SearchWidget(size: size, controllerText: controllerText),
              const SizedBox(height: AppDimens.d12),
              SliverContact(size: size, controller: controller),
              const SizedBox(height: AppDimens.d12),
              Column(
                children: [
                  for (var i = 0; i < widget.userList.length; i++)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              "edit",
                              arguments: widget.userList[i],
                            );
                          },
                          child: ListTile(
                            leading: ClipOval(child: Image.asset(widget.userList[i].imgUrl)),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.userList[i].name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.userList.removeAt(i);
                                    });
                                  },
                                  icon: AppIcons.delete,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: AppIcons.edit,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(String imgUrl, void Function() onPressed) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: AppDimens.d40,
              height: AppDimens.d40,
              child: Image.asset(imgUrl),
            ),
            SizedBox(width: 30),
            Text(
              AppStrings.contacts,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppDimens.d24,
              ),
            ),
            SizedBox(width: 30),
            SizedBox(
              width: AppDimens.d50,
              height: AppDimens.d50,
              child: Card(
                color: Colors.cyan,
                child: Center(
                  child: IconButton(onPressed: onPressed, icon: AppIcons.edit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
