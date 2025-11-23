import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/models/chat_user_model.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/services/database_service.dart';
import 'package:nextalk/services/navigation_service.dart';

class UsersPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;
  late DatabaseService _database;
  late NavigationService _navigation;
  List<ChatUserModel>? users;
  late List<ChatUserModel> _selectedUsers;
  List<ChatUserModel> get selectedUsers {
    return _selectedUsers;
  }

  UsersPageProvider(this._auth) {
    _selectedUsers = [];
    _database = GetIt.instance.get<DatabaseService>();
    _navigation = GetIt.instance.get<NavigationService>();
  }

  @override
  void dispose() {
   
    super.dispose();
    
  }
}
