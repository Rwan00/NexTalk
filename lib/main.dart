import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextalk/firebase_options.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/routes/app_routes.dart';
import 'package:nextalk/routes/pages_routes.dart';
import 'package:nextalk/services/navigation_service.dart';
import 'package:nextalk/services/notification_service.dart';

import 'package:nextalk/services/register_services.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: false,
        sound: true,
      );
  await NotificationService.initializeNotification();
  registerServices();
  runApp(const NexTalk());
}

class NexTalk extends StatelessWidget {
  const NexTalk({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (context) => AuthenticationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kPrimaryColor),
          scaffoldBackgroundColor: AppColors.kBackgroundColor,
          textTheme: GoogleFonts.nunitoTextTheme(),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: AppColors.kSecondaryColor,
            unselectedItemColor: Colors.grey,
          ),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: PagesRoutes.kLoginPage,
        routes: routes(),
      ),
    );
  }
}

Future<void> _onBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log("We have recieved a notification ${message.notification}");
}
