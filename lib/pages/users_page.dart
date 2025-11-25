import 'package:flutter/material.dart';
import 'package:nextalk/models/user_model.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/providers/users_page_provider.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/widgets/custom_button.dart';
import 'package:nextalk/widgets/custom_snackbar.dart';
import 'package:nextalk/widgets/custom_text_form_field.dart';
import 'package:nextalk/widgets/top_bar.dart';
import 'package:nextalk/widgets/users_list_view.dart';
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
  late UsersPageProvider _usersPageProvider;

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_usersPageProvider.usersStatus == UsersStatus.success) {
        CustomSnackBar.show(context, message: "Chat Created Successfully");
        _usersPageProvider.usersStatus = UsersStatus.init; // reset
      } else if (_usersPageProvider.usersStatus == UsersStatus.error) {
        CustomSnackBar.show(
          context,
          message: _usersPageProvider.errorMessage ?? "Something went wrong",
          isError: true,
        );
        _usersPageProvider.usersStatus = UsersStatus.init; // reset
      }
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersPageProvider>(
          create: (_) => UsersPageProvider(_auth),
        ),
      ],
      child: Builder(
        builder: (context) {
          _usersPageProvider = context.watch<UsersPageProvider>();
          List<UserModel>? users = _usersPageProvider.users;
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
                    icon: Icon(
                      Icons.logout_outlined,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
                CustomTextFormField(
                  controller: _searchController,
                  hintText: "Search...",
                  onEditingComplete: (value) {
                    _usersPageProvider.getUsers(name: value);
                    FocusScope.of(context).unfocus();
                  },
                  icon: Icons.search,
                ),

                UsersListView(
                  users: users,
                  deviceHeight: _deviceHeight,
                  usersPageProvider: _usersPageProvider,
                ),
                if (_usersPageProvider.selectedUsers.isNotEmpty)
                  CustomButton(
                    name: _usersPageProvider.selectedUsers.length == 1
                        ? "Chat With ${_usersPageProvider.selectedUsers.first.name}"
                        : "Create Group Chat",
                    height: _deviceHeight * 0.08,
                    width: _deviceWidth * 0.80,
                    onPressed: () {
                      _usersPageProvider.createChat();
                    },
                    isLoading:
                        _usersPageProvider.usersStatus == UsersStatus.loading,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
