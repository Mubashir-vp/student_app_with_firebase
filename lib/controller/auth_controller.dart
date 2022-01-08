// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/controller/myapp_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:firebase_sample/view/loginpage.dart';
import 'package:firebase_sample/view/myapp.dart';
import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  static var url;

  static var email;
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initalScreen);
    update();
  }

  _initalScreen(User? user) {
    if (user == null) {
      print("null");
      Get.offAll(() => const Loginpage());
    } else {
      print(user.email);
      email = user.email;
      update();
      gettinguserdetails();
      // checkingProfilePicture();
      Get.offAll(() => MyApp(
            email: user.email,
          ));
    }
  }

  var datas;
  gettinguserdetails() {
    var document =
        FirebaseFirestore.instance.collection(email!).doc("userDetails");
    document.get().then((value) {
      datas = value['name'];
      print(datas);
      update();
    }).whenComplete(() => checkingProfilePicture());
  }

  checkingProfilePicture() async {
    final destination = '$datas/$datas profile';
    print('$datas/$datas profile');
    try {
      var dbreference = FirebaseStorage.instance.ref(destination);
      url = await dbreference.getDownloadURL();
      print(url);
      update();
    } catch (e) {
      return;
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar("TryAgain", " Something went wrong",
          backgroundColor: Colors.blueAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Failed to create account",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          messageText: Text(e.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500)));
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("TryAgain", " Something went wrong",
          backgroundColor: Colors.blueAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Failed to login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          messageText: Text(e.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500)));
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
