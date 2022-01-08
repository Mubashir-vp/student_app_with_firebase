import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'auth_controller.dart';

class EditController extends GetxController{
   var name;
   var department;
   var age;
   void onInit(){
     super.onInit();
     gettinguserdetails();
   }
  gettinguserdetails() async {
    var document = FirebaseFirestore.instance
        .collection(AuthController.email!)
        .doc("userDetails");
    document.get().then((value) {
      name = value['name'];
      age=value['age'];
      department=value[department]
;      update();
    });
  }

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
initialValue:name,            keyboardType: TextInputType.name,
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
initialValue:age ,             
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
              initialValue: department,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "Enter  Your Department",
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(.18),
                      fontWeight: FontWeight.w900)),
            ),
          ),
        ),
        
       
        // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //   Padding(
        //     padding: const EdgeInsets.all(30.0),
        //     child: ElevatedButton(
        //         onPressed: () async {
        //           Model model = Model(
        //               age: int.parse(ageController.text),
        //               email: emailController.text,
        //               password: passwordController.text,
        //               department: departmentController.text,
        //               name: nameController.text,
        //               id: collectionInstance().id);
        //           var json = model.toJson();
        //           update();
        //           await collectionInstance().set(json);
        //           AuthController.instance
        //               .register(emailController.text, passwordController.text);
        //           FocusScopeNode currentFocus = FocusScope.of(context);
        //           if (!currentFocus.hasPrimaryFocus) {
        //             currentFocus.unfocus();
        //           }
        //         },
        //         child: const Text("Join")),
        //   )
        // ]),
      ],
    );
  }

}