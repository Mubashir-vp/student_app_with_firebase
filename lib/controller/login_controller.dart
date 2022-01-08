import 'package:firebase_sample/controller/auth_controller.dart';
import 'package:firebase_sample/view/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool obsecureText = true;

  Widget body({required var context}) {
    var height = MediaQuery.of(context).size.height;
    void onInit() {
      super.onInit();
      update();
    }

    return Column(
      children: [
        SizedBox(
          height: height / 6,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: SizedBox(
            child: Text(
              "Login",
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
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
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
              textInputAction: TextInputAction.done,
              controller: passwordcontroller,
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
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                  hintText: "Enter Your password",
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
                onPressed: () {
                  AuthController.instance
                      .login(emailController.text, passwordcontroller.text);
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: const Text("Login")),
          )
        ]),
        RichText(
            text: TextSpan(
                text: "New user ?",
                style: const TextStyle(color: Colors.black),
                children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      Get.to(const SignUp());
                    },
                  text: "  Click Here To SignUp",
                  style: const TextStyle(color: Colors.blueAccent))
            ]))
      ],
    );
  }
}
