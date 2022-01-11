import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/controller/myapp_controller.dart';
import 'package:firebase_sample/view/myapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'auth_controller.dart';

class EditController extends GetxController {
  var changedName;
  var changedAge;
  var changedDep;

  Widget body({required var context}) {
    var height = MediaQuery.of(context).size.height;

    return GetBuilder<Myappcontroller>(
        init: Myappcontroller(),
        builder: (cont) {
          return Column(
            children: [
              SizedBox(
                height: height / 12,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  child: Text(
                    "Edit Your Details",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w800,
                        fontSize: 30),
                  ),
                ),
              ),
              SizedBox(
                height: height / 15,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  child: TextFormField(
                    onChanged: (changed) {
                      final doc = FirebaseFirestore.instance
                          .collection(AuthController.email)
                          .doc("userDetails");
                      doc.update({
                        'name': changed,
                      });
                      update(["auth", "myapp"]);
                    },
                    textInputAction: TextInputAction.next,
                    initialValue: cont.datas.toString(),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: "Enter Your FullName",
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(.18),
                            fontWeight: FontWeight.w900)),
                  ),
                ),
              ),
             
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  child: TextFormField(
                    onChanged: (changed) {
                      final doc = FirebaseFirestore.instance
                          .collection(AuthController.email)
                          .doc("userDetails");
                      doc.update({
                        'department': changed,
                      });
                      update(["auth", "myapp"]);
                    },
                    textInputAction: TextInputAction.next,
                    initialValue: cont.department.toString(),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        // hintText: "Enter  Your Department",
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(.18),
                            fontWeight: FontWeight.w900)),
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        update(["auth", "myapp"]);
                        Get.to(MyApp(email: AuthController.email,));
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: const Text("Update")),
                )
              ]),
            ],
          );
        });
  }
}
