import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/models/chat_user_model.dart';
import 'package:nextalk/routes/pages_routes.dart';
import 'package:nextalk/services/database_service.dart';
import 'package:nextalk/services/navigation_service.dart';

enum AuthStatus { init, loading, success, error }

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;
  late ChatUserModel chatUser;
  AuthStatus loginStatus = AuthStatus.init;
  String? errorMessage;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();

    // _auth.signOut();
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        log("Logged In");

       
        await _databaseService.updateUserLastSeenTime(user.uid);

        try {
         
          final snapShot = await _databaseService.getUser(user.uid);
          Map<String, dynamic> userData =
              snapShot.data() as Map<String, dynamic>;

          chatUser = ChatUserModel.fromJson({
            "uid": user.uid,
            "name": userData["name"],
            "email": userData["email"],
            "last_active": userData["last_active"],
            "image": userData["image"],
          });

         
          _navigationService.removeAndNavigateToRoute(PagesRoutes.kHomePage);
        } catch (e) {
          log("Error fetching user data: $e");
       
        }
      } else {
        _navigationService.removeAndNavigateToRoute(PagesRoutes.kLoginPage);
        log("Not Authenticated");
      }
    });
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      loginStatus = AuthStatus.loading;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      loginStatus = AuthStatus.success;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      errorMessage = e.message;
      loginStatus = AuthStatus.error;
    } catch (e) {
      log(e.toString());
      errorMessage = e.toString();
      loginStatus = AuthStatus.error;
    }
  }

  Future<String?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      loginStatus = AuthStatus.loading;
      notifyListeners();
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      loginStatus = AuthStatus.success;
      notifyListeners();
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      errorMessage = e.message;
      loginStatus = AuthStatus.error;
    } catch (e) {
      log(e.toString());
      errorMessage = e.toString();
      loginStatus = AuthStatus.error;
    }

    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
