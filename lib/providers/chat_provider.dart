// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:nextalk/models/chat_message_model.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/services/cloud_storage_service.dart';
import 'package:nextalk/services/database_service.dart';
import 'package:nextalk/services/media_service.dart';
import 'package:nextalk/services/navigation_service.dart';

class ChatProvider extends ChangeNotifier {
  late DatabaseService _db;
  late CloudStorageService _storage;
  late MediaService _media;
  late NavigationService _navigation;
  AuthenticationProvider _auth;
  ScrollController _messagesController;
  String _chatId;
  List<ChatMessageModel>? messages;
  late StreamSubscription _messagesStream;
  String? _message;
  ChatProvider(this._auth, this._messagesController, this._chatId) {
    _db = GetIt.instance.get<DatabaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _media = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
    listenToMessages();
  }
  String? get message {
    return _message;
  }

  @override
  void dispose() {
    _messagesStream.cancel();
    super.dispose();
  }

  void listenToMessages() {
    try {
      _messagesStream = _db.streamMessagesForChat(_chatId).listen((snapshot) {
        List<ChatMessageModel> messagesSnapshot = snapshot.docs.map((m) {
          Map<String, dynamic> messageData = m.data() as Map<String, dynamic>;
          return ChatMessageModel.fromJson(messageData);
        }).toList();
        messages = messagesSnapshot;
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
