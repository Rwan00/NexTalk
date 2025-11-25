import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/models/chat_message_model.dart';
import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/models/user_model.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/services/database_service.dart';

class ChatsPageProvider extends ChangeNotifier {
  final AuthenticationProvider _auth;
  late DatabaseService _db;
  List<ChatModel>? chats;
  late StreamSubscription _chatsStream;
  final Map<String, StreamSubscription> _messageSubscriptions = {};
  ChatsPageProvider(this._auth) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }
  @override
  void dispose() {
    _chatsStream.cancel();
    for (var sub in _messageSubscriptions.values) {
      try {
        sub.cancel();
      } catch (_) {}
    }
    _messageSubscriptions.clear();

    super.dispose();
  }

   void getChats() async {
    try {
      _chatsStream = _db.getChatsForUser(_auth.userModel.uid).listen((
        snapshot,
      ) async {
        chats = await Future.wait(
          snapshot.docs.map((d) async {
            Map<String, dynamic> chatData = d.data() as Map<String, dynamic>;

            // Get Users
            List<UserModel> members = [];
            for (var uid in chatData["members"]) {
              DocumentSnapshot userSnapshot = await _db.getUser(uid);
              Map<String, dynamic> userData =
                  userSnapshot.data() as Map<String, dynamic>;
              userData["uid"] = userSnapshot.id;
              members.add(UserModel.fromJson(userData));
            }

            //Get Messages
            List<ChatMessageModel> messages = [];
            QuerySnapshot chatMessages = await _db.getLastMessageForChat(d.id);
            if (chatMessages.docs.isNotEmpty) {
              Map<String, dynamic> messageData =
                  chatMessages.docs.first.data() as Map<String, dynamic>;
              ChatMessageModel message = ChatMessageModel.fromJson(messageData);
              messages.add(message);
            }

            return ChatModel(
              uid: d.id,
              currentUserId: _auth.userModel.uid,
              isActivity: chatData["is_activity"],
              isGroup: chatData["is_group"],
              members: members,
              messages: messages,
            );
          }).toList(),
        );
        notifyListeners();
      });
    } catch (e) {
      log("Error GetChats : ${e.toString()}");
    }
  }
}
