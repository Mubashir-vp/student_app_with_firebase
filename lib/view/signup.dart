import 'package:firebase_sample/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(SignUpController());
    return SafeArea(
      child: Scaffold(
        body:GetBuilder<SignUpController>(
          init: SignUpController(),
          builder: (controll) {
            return SingleChildScrollView(child:controller.body(context: context) ,);
          }
        ) ,
      ),
    );
  }
}
