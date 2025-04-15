import 'package:flutter/material.dart';
import 'package:state_managment/contact_app/core/theme/colors.dart';
import 'package:state_managment/contact_app/core/theme/dimens.dart';
import 'package:state_managment/contact_app/core/theme/icons.dart';
import 'package:state_managment/contact_app/core/theme/strings.dart';
import 'package:state_managment/contact_app/model/user_model.dart';

import '../core/config/app_routes.dart';

class Home extends StatefulWidget {
  final List<User> userList;
  const Home({super.key, required this.userList});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index1 = 0;
  int index = 0;
  final controllerText = TextEditingController();
  final controller = ScrollController();

  @override
  void dispose() {
    controllerText.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String imgUrl = widget.userList[index1].imgUrl;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: _buildAppBar(imgUrl, () {}),
      body: Padding(
        padding: EdgeInsets.all(AppDimens.d10),
        child: SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SearchWidget(size: size, controllerText: controllerText),
              const SizedBox(height: AppDimens.d12),
              SliverContact(size: size, controller: controller),
              const SizedBox(height: AppDimens.d12),
              Column(
                children: [
                  for (var o in widget.userList)
                    Column(
                      children: [
                        GestureDetector(
                          onTap:(){},/// edit page ga otadi
                          child: ListTile(
                            leading: ClipOval(child: Image.asset(o.imgUrl)),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    o.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
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
                            onTap: (){Navigator.pushNamed(context, AppRoutes.edit);},
                            child: Card(
                              color: AppColors.black,
                              child: Image.asset(
                                o.imgUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Text(o.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: AppDimens.d16),))
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

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.size,
    required this.controllerText,
  });

  final Size size;
  final TextEditingController controllerText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.d55,
      width: size.width - 20,
      child: Card(
        color: AppColors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: TextField(
            controller: controllerText,
            maxLength: 40,
            decoration: InputDecoration(
              counterText: "",
              hintText: AppStrings.search,
              hintStyle: TextStyle(color: AppColors.grey2),
              suffixIcon: IconButton(
                onPressed: () {},

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
