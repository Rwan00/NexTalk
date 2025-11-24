import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nextalk/models/chat_user_model.dart';
import 'package:nextalk/providers/users_page_provider.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/user_list_tile_widget.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({
    super.key,
    required this.users,
    required double deviceHeight,
    required UsersPageProvider usersPageProvider,
  }) : _deviceHeight = deviceHeight,
       _usersPageProvider = usersPageProvider;

  final List<ChatUserModel>? users;
  final double _deviceHeight;
  final UsersPageProvider _usersPageProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (() {
        if (users != null) {
          if (users!.isNotEmpty) {
            return ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                return UserListTileWidget(
                  height: _deviceHeight * 0.10,
                  user: users![index],
                  onTap: () {
                    _usersPageProvider.updateSelectedUsers(users![index]);
                  },
                  isSelected: _usersPageProvider.selectedUsers.contains(
                    users![index],
                  ),
                );
              },
            );
          } else {
            return Align(
              alignment: Alignment.center,
              child: Text(
                "No Users Found...",
                style: AppTextStyles.textStyle12Primary,
              ),
            );
          }
        } else {
          return Center(
            child: SpinKitCircle(
              color: AppColors.kPrimaryColor,
              size: _deviceHeight * 0.06,
            ),
          );
        }
      })(),
    );
  }
}
