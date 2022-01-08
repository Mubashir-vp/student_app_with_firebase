import 'package:firebase_sample/controller/editpage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<EditController>(
          init: EditController(),
          builder: (controller) {
            return Scaffold(
              body: controller.body(context: context),
            );
          }),
    );
  }
}
