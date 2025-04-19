import 'package:flutter/material.dart';
import 'package:state_managment/contact_app/core/theme/colors.dart';
import 'package:state_managment/contact_app/core/theme/dimens.dart';
import 'package:state_managment/contact_app/core/theme/icons.dart';
import 'package:state_managment/contact_app/core/theme/strings.dart';
import 'package:state_managment/contact_app/core/theme/widgets.dart';
import 'package:state_managment/contact_app/model/user_model.dart';

import '../core/config/app_routes.dart';
final key=UniqueKey();
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controllerText = TextEditingController();
  final ScrollController controller = ScrollController();

  List<User> searchResults = [];
  List<User> recentSearched = [];

  @override
  void dispose() {
    controllerText.dispose();
    controller.dispose();
    super.dispose();
  }

  void searchUsers() {
    final query = controllerText.text.toLowerCase().trim();

    setState(() {
      searchResults =
          userList.where((user) => user.name.toLowerCase() == query).toList();

      if (searchResults.isNotEmpty) {
        final found = searchResults.first;

        recentSearched.removeWhere((u) => u.name == found.name);
        recentSearched.insert(0, found);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      key:widget.key,
      floatingActionButton: const AddButton(),
      appBar: AppBar(
        title: const Text("Search Contacts"),
        backgroundColor: AppColors.blue,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.d10),
        child: Column(
          children: [
            SizedBox(
              height: AppDimens.d55,
              width: size.width,
              child: Card(
                color: AppColors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: TextField(
                    controller: controllerText,
                    onSubmitted: (_) => searchUsers(),
                    maxLength: 40,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: AppStrings.search,
                      hintStyle: TextStyle(color: AppColors.grey2),
                      suffixIcon: IconButton(
                        icon: AppIcons.search,
                        onPressed: searchUsers,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.d16,
                        vertical: AppDimens.d12,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (searchResults.isNotEmpty)
              ...searchResults.map(
                (user) => ListTile(
                  leading: ClipOval(child: Image.asset(user.imgUrl)),
                  title: Text(
                    "${user.name}\n${user.number}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            if (searchResults.isEmpty && controllerText.text.isNotEmpty)
              const Text("No result found"),

            const SizedBox(height: 30),

            if (recentSearched.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Last Searches",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...recentSearched.map(
                    (user) => GestureDetector(
                     onTap: (){
                       Navigator.pushNamed(
                         context,
                         AppRoutes.edit,
                         arguments:user,
                       );

                     },
                      child: ListTile(

                        leading: ClipOval(child: Image.asset(user.imgUrl)),
                        title: Text("${user.name}\n${user.number}"),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
