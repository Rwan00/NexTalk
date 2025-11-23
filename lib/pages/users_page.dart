import 'package:flutter/material.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/widgets/custom_text_form_field.dart';
import 'package:nextalk/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.03,
        vertical: _deviceHeight * 0.02,
      ),
      height: _deviceHeight * 0.98,
      width: _deviceWidth * 0.97,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopBar(
            title: "Users",
            primaryAction: IconButton(
              onPressed: () {
                _auth.logout();
              },
              icon: Icon(Icons.logout_outlined, color: AppColors.kPrimaryColor),
            ),
          ),
          CustomTextFormField(
            controller: _searchController,
            hintText: "Search...",
            onEditingComplete: (value) {},
            icon: Icons.search,
          ),
        ],
      ),
    );
  }
}
