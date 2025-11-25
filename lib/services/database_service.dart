import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nextalk/models/chat_message_model.dart';

const String USER_COLLECTION = "users";
const String CHAT_COLLECTION = "chats";
const String MESSAGES_COLLECTION = "messages";

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(
    String uid,
    String email,
    String imageUrl,
    String name,
  ) async {
    try {
      final String token = "";
      await _db.collection(USER_COLLECTION).doc(uid).set({
        "email": email,
        "image": imageUrl,
        "last_active": DateTime.now().toUtc(),
        "name": name,
        "token":token,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<DocumentSnapshot> getUser(String uid) {
    return _db.collection(USER_COLLECTION).doc(uid).get();
  }

  Future<QuerySnapshot> getUsers({String? name}) {
    Query query = _db.collection(USER_COLLECTION);
    if (name != null) {
      query = query
          .where("name", isGreaterThanOrEqualTo: name)
          .where("name", isLessThanOrEqualTo: "${name}z");
    }
    return query.get();
  }

  Stream<QuerySnapshot> getChatsForUser(String uid) {
    return _db
        .collection(CHAT_COLLECTION)
        .where("members", arrayContains: uid)
        .snapshots();
  }

  Future<QuerySnapshot> getLastMessageForChat(String chatId) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(chatId)
        .collection(MESSAGES_COLLECTION)
        .orderBy("sent_time", descending: true)
        .limit(1)
        .get();
  }

  Stream<QuerySnapshot> streamMessagesForChat(String chatId) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(chatId)
        .collection(MESSAGES_COLLECTION)
        .orderBy("sent_time", descending: false)
        .snapshots();
  }

  Future<void> addMessageToChat(String chatId, ChatMessageModel message) async {
    try {
      await _db
          .collection(CHAT_COLLECTION)
          .doc(chatId)
          .collection(MESSAGES_COLLECTION)
          .doc(message.uid)
          .set(message.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateChatData(String chatId, Map<String, dynamic> data) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(chatId).update(data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateUserLastSeenTime(String uid) async {
    try {
      await _db.collection(USER_COLLECTION).doc(uid).update({
        "last_active": DateTime.now().toUtc(),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(chatId).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<DocumentReference?> createChat(Map<String, dynamic> data) async {
    try {
      DocumentReference chat = await _db.collection(CHAT_COLLECTION).add(data);
      return chat;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
