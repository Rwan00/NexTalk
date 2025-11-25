import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/models/user_model.dart';
import 'package:nextalk/pages/chat_page.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/services/database_service.dart';
import 'package:nextalk/services/navigation_service.dart';

enum UsersStatus { init, loading, success, error }

class UsersPageProvider extends ChangeNotifier {
  final AuthenticationProvider _auth;
  late DatabaseService _database;
  late NavigationService _navigation;
  List<UserModel>? users;
  late List<UserModel> _selectedUsers;
  UsersStatus usersStatus = UsersStatus.init;
  String? errorMessage;
  List<UserModel> get selectedUsers {
    return _selectedUsers;
  }

  UsersPageProvider(this._auth) {
    _selectedUsers = [];
    _database = GetIt.instance.get<DatabaseService>();
    _navigation = GetIt.instance.get<NavigationService>();
    getUsers();
  }

  void getUsers({String? name}) {
    _selectedUsers = [];
    try {
      _database.getUsers(name: name).then((snapshot) {
        users = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data["uid"] = doc.id;
          return UserModel.fromJson(data);
        }).where((user)=>user.uid != _auth.userModel.uid).toList();
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void updateSelectedUsers(UserModel user) {
    if (_selectedUsers.contains(user)) {
      _selectedUsers.remove(user);
    } else {
      _selectedUsers.add(user);
    }
    notifyListeners();
  }

  void createChat() async {
    try {
      usersStatus = UsersStatus.loading;
      notifyListeners();
      List<String> membersIds = _selectedUsers.map((user) => user.uid).toList();
      membersIds.add(_auth.userModel.uid);
      bool isGroup = _selectedUsers.length > 1;
      DocumentReference? doc = await _database.createChat({
        "is_group": isGroup,
        "is_activity": false,
        "members": membersIds,
      });

      List<UserModel> members = [];
      for (var uid in membersIds) {
        DocumentSnapshot userSnapshot = await _database.getUser(uid);
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        userData["uid"] = userSnapshot.id;
        members.add(UserModel.fromJson(userData));
        ChatPage chatPage = ChatPage(
          chatModel: ChatModel(
            uid: doc!.id,
            currentUserId: _auth.userModel.uid,
            isActivity: false,
            isGroup: isGroup,
            members: members,
            messages: [],
            
          ),
         
        );
        _selectedUsers = [];
        notifyListeners();
        _navigation.navigateToPage(chatPage);
        usersStatus = UsersStatus.success;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      usersStatus = UsersStatus.error;
      notifyListeners();
    }
  }
}
