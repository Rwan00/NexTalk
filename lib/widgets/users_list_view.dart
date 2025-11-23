import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nextalk/models/chat_user_model.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/user_list_tile_widget.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({
    super.key,
    required this.users,
    required double deviceHeight,
  }) : _deviceHeight = deviceHeight;

  final List<ChatUserModel>? users;
  final double _deviceHeight;

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
                  onTap: () {},
                  isSelected: false,
                );
              },
            );
          } else {
            return Text("No Users Found...", style: AppTextStyles.headingStyle);
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
