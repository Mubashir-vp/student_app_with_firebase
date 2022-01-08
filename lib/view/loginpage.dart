import 'package:firebase_sample/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controll) {
            return SingleChildScrollView(
              child: controller.body(context: context)
            );
          }
        ),
      ),
    );
  }
}
