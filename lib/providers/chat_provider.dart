// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  String? _message;
  ChatProvider(this._auth, this._messagesController, this._chatId) {
    _db = GetIt.instance.get<DatabaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _media = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
  }
  String? get message {
    return _message;
  }

  @override
  void dispose() {
    super.dispose();
  }

  
}
