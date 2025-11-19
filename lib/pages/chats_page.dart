import 'package:flutter/material.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/widgets/list_tile_widget.dart';
import 'package:nextalk/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
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
            title: "Chats",
            primaryAction: IconButton(
              onPressed: () {},
              icon: Icon(Icons.logout_outlined, color: AppColors.kPrimaryColor),
            ),
          ),
          ListTileWidget(
            height: _deviceHeight * 0.10,
            title: "Riwa",
            subtitle: "Hey!",
            imagePath:
                "https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg",
            isActive: false,
            isActivity: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
