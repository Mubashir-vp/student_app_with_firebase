import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/controller/auth_controller.dart';
import 'package:firebase_sample/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignUpController extends GetxController {
  bool obsecureText = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  collectionInstance() {
    return FirebaseFirestore.instance
        .collection("StudentApp")
        .doc(emailController.text)
        .collection("UserDetails").doc(nameController.text);
  }

  late Model model;

  Widget body({required var context}) {
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: height / 12,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: SizedBox(
            child: Text(
              "SignUp",
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
              textInputAction: TextInputAction.next,
              controller: nameController,
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
              textInputAction: TextInputAction.next,
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter Your AGE",
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
              textInputAction: TextInputAction.next,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Enter Your Email",
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
              textInputAction: TextInputAction.next,
              controller: departmentController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "Enter  Your Department",
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
              textInputAction: TextInputAction.done,
              controller: passwordController,
              obscureText: obsecureText,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () {
                        obsecureText == true
                            ? obsecureText = false
                            : obsecureText = true;

                        update();
                      },
                      child: Icon(
                          obsecureText == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: obsecureText == true
                              ? Colors.grey
                              : Colors.blueAccent)),
                  hintText: "Enter Your password",
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
              textInputAction: TextInputAction.done,
              controller: passwordController,
              obscureText: obsecureText,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () {
                        obsecureText == true
                            ? obsecureText = false
                            : obsecureText = true;

                        update();
                      },
                      child: Icon(
                          obsecureText == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: obsecureText == true
                              ? Colors.grey
                              : Colors.blueAccent)),
                  hintText: "Confirm Your password",
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
                  Model model = Model(
                      age: int.parse(ageController.text),
                      email: emailController.text,
                      password: passwordController.text,
                      department: departmentController.text,
                      name: nameController.text,
                      id: collectionInstance().id);
                  var json = model.toJson();
                  update();
                  await collectionInstance().set(json);
                  AuthController.instance
                      .register(emailController.text, passwordController.text);
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: const Text("Join")),
          )
        ]),
      ],
    );
  }
}
