import 'dart:async';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
  final AuthenticationProvider _auth;
  final ScrollController _messagesController;
  final String _chatId;
  List<ChatMessageModel>? messages;
  late StreamSubscription _messagesStream;
  late StreamSubscription _keyboardVisibilityStream;
  late KeyboardVisibilityController _keyboardVisibilityController;
  String? _message;
  ChatProvider(this._auth, this._messagesController, this._chatId) {
    _db = GetIt.instance.get<DatabaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _media = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
    _keyboardVisibilityController = KeyboardVisibilityController();
    listenToMessages();
    listenToKeyboardChanges();
  }
  String? get message {
    return _message;
  }

  void set message(String? value) {
    _message = value;
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
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          if (_messagesController.hasClients) {
            _messagesController.jumpTo(
              _messagesController.position.maxScrollExtent,
            );
          }
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void listenToKeyboardChanges() {
    _keyboardVisibilityStream = _keyboardVisibilityController.onChange.listen((
      event,
    ) {
      _db.updateChatData(_chatId, {"is_activity": event});
    });
    notifyListeners();
  }

  void sendTextMessage() {
    if (_message != null) {
      ChatMessageModel messageToSend = ChatMessageModel(
        type: MessageType.TEXT,
        content: _message!,
        senderId: _auth.chatUser.uid,
        sentTime: DateTime.now(),
      );
      _db.addMessageToChat(_chatId, messageToSend);
    }
  }

  void sendImageMessage() async {
    try {
      PlatformFile? file = await _media.pickImageFromLibrary();
      if (file != null) {
        String? dounloadUrl = await _storage.saveChatImageToStorage(
          _chatId,
          _auth.chatUser.uid,
          file,
        );
        ChatMessageModel messageToSend = ChatMessageModel(
          type: MessageType.IMAGE,
          content: dounloadUrl!,
          senderId: _auth.chatUser.uid,
          sentTime: DateTime.now(),
        );
        _db.addMessageToChat(_chatId, messageToSend);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void deleteChat() {
    goBack();
    _db.deleteChat(_chatId);
  }

  void goBack() {
    _navigation.goBack();
  }
}
