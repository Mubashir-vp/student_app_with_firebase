import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sample/controller/auth_controller.dart';

import 'package:firebase_sample/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false ,
    home: SplashScreen()));
}
