import 'package:flutter/material.dart';
import 'package:state_managment/contact_app/core/theme/colors.dart';
import 'package:state_managment/contact_app/core/theme/dimens.dart';
import 'package:state_managment/contact_app/core/theme/icons.dart';
import 'package:state_managment/contact_app/core/theme/strings.dart';
import 'package:state_managment/contact_app/model/user_model.dart';
import 'package:state_managment/contact_app/pages/search_page.dart';

import '../core/config/app_routes.dart';
import '../core/theme/widgets.dart';
import '../core/utils/snack_bar.dart';

class Home extends StatefulWidget {
  final InheritedData inheritedData;
  const Home({super.key, required this.inheritedData});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  bool didUpdateWidget(covariant Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    return oldWidget.inheritedData.listUser != userList;
  }

  final controllerText = TextEditingController();
  final controller = ScrollController();
  int index = 0;
  String selectedSort = "";

  late List<User> _userList;

  @override
  void initState() {
    super.initState();
    _userList = widget.inheritedData.listUser;
  }

  @override
  void dispose() {
    controllerText.dispose();
    controller.dispose();
    super.dispose();
  }

  final key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    if (widget.inheritedData.listUser.isEmpty) {
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
      key: key,
      appBar: _buildAppBar(
        InheritedData.of(context).listUser[index].imgUrl,
        () {},
      ),
      backgroundColor: AppColors.white,
      floatingActionButton: const AddButton(),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.d10),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              const SizedBox(height: AppDimens.d12),
              SliverContact(size: size, controller: controller),
              sorted(),
              const SizedBox(height: AppDimens.d12),
              SearchWidget(
                size: size,
                controllerText: controllerText,
                onTap: () {
                  final searchPage = const SearchPage(key: ValueKey("search"));

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => searchPage),
                  );
                },
              ),

              const SizedBox(height: AppDimens.d12),
              Column(
                children: [
                  for (var i = 0; i < widget.inheritedData.listUser.length; i++)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.edit,
                              arguments: widget.inheritedData.listUser[i],
                            );
                          },
                          child: ListTile(
                            leading: ClipOval(
                              child: Image.asset(
                                widget.inheritedData.listUser[i].imgUrl,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${widget.inheritedData.listUser[i].name}"
                                    "\n${widget.inheritedData.listUser[i].number}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final removedName =
                                        widget.inheritedData.listUser[i].name;
                                    setState(() {
                                      widget.inheritedData.listUser.removeAt(i);
                                    });
                                    showInfoSnackBar(
                                      null,
                                      context: context,
                                      message: '$removedName removed',
                                    );
                                  },
                                  icon: AppIcons.delete,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.edit,
                                      arguments:
                                          widget.inheritedData.listUser[i],
                                    );
                                  },
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

  Align sorted() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        color: Colors.cyan,
        child: DropdownMenu<String>(
          trailingIcon: AppIcons.sort,
          initialSelection: selectedSort,
          width: 100,
          dropdownMenuEntries: const [
            DropdownMenuEntry(
              value: "az",
              label: "A-Z",
              leadingIcon: Icon(Icons.sort_by_alpha),
            ),
            DropdownMenuEntry(
              value: "za",
              label: "Z-A",
              leadingIcon: Icon(Icons.sort_by_alpha_outlined),
            ),
          ],
          onSelected: (value) {
            setState(() {
              selectedSort = value ?? "none";
              if (value == "az") {
                _userList.sort((a, b) => a.name.compareTo(b.name));
              } else if (value == "za") {
                _userList.sort((a, b) => b.name.compareTo(a.name));
              }
            });
          },
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
