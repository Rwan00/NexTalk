import 'package:flutter/material.dart';
import 'package:nextalk/pages/login_page.dart';
import 'package:nextalk/routes/pages_routes.dart';

Map<String, Widget Function(BuildContext)> routes (){
  return {
  PagesRoutes.kLoginPage :(context)=>LoginPage(),
};
}
