import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/models/chat_message_model.dart';
import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/models/chat_user_model.dart';
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
      _chatsStream = _db.getChatsForUser(_auth.chatUser.uid).listen((
        snapshot,
      ) async {
        // Build base chat models with members (no messages yet)
        List<ChatModel> latestChats = await Future.wait(
          snapshot.docs.map((d) async {
            Map<String, dynamic> chatData = d.data() as Map<String, dynamic>;

            // Get Users
            List<ChatUserModel> members = [];
            for (var uid in chatData["members"]) {
              DocumentSnapshot userSnapshot = await _db.getUser(uid);
              Map<String, dynamic> userData =
                  userSnapshot.data() as Map<String, dynamic>;
              userData["uid"] = userSnapshot.id;
              members.add(ChatUserModel.fromJson(userData));
            }

            return ChatModel(
              uid: d.id,
              currentUserId: _auth.chatUser.uid,
              isActivity: chatData["is_activity"],
              isGroup: chatData["is_group"],
              members: members,
              messages: [],
            );
          }).toList(),
        );

        // Cancel subscriptions for chats that were removed
        final newIds = snapshot.docs.map((d) => d.id).toSet();
        final removedIds = _messageSubscriptions.keys
            .where((id) => !newIds.contains(id))
            .toList();
        for (var id in removedIds) {
          try {
            _messageSubscriptions[id]?.cancel();
          } catch (_) {}
          _messageSubscriptions.remove(id);
        }

        chats = latestChats;
        notifyListeners();

        // Ensure we have a listener for the last message of each chat so it updates in real time
        for (var d in snapshot.docs) {
          final chatId = d.id;
          if (_messageSubscriptions.containsKey(chatId)) continue;

          _messageSubscriptions[chatId] = _db
              .getLastMessageForChat(chatId)
              .listen(
                (chatMessagesSnapshot) {
                  if (chatMessagesSnapshot.docs.isNotEmpty) {
                    final doc = chatMessagesSnapshot.docs.first;
                    Map<String, dynamic> messageData =
                        doc.data() as Map<String, dynamic>;
                    messageData["uid"] = doc.id;
                    ChatMessageModel message = ChatMessageModel.fromJson(
                      messageData,
                    );
                    final idx = chats?.indexWhere((c) => c.uid == chatId) ?? -1;
                    if (idx != -1) {
                      chats![idx].messages = [message];
                      notifyListeners();
                    }
                  } else {
                    final idx = chats?.indexWhere((c) => c.uid == chatId) ?? -1;
                    if (idx != -1) {
                      chats![idx].messages = [];
                      notifyListeners();
                    }
                  }
                },
                onError: (e) {
                  log('Error listening to messages for $chatId: $e');
                },
              );
        }
      });
    } catch (e) {
      log("Error GetChats : ${e.toString()}");
    }
  }
}
