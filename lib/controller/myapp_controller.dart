import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_sample/controller/auth_controller.dart';
import 'package:firebase_sample/view/editpage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class Myappcontroller extends GetxController {
  Myappcontroller({
    this.collectionInstance,
  });
  var controller = Get.put(AuthController());
  // ignore: prefer_typing_uninitialized_variables
  void onInit() {
    super.onInit();
    gettinguserdetails();
    savingProfile();
  }

  var collectionInstance;
  File? file;
  UploadTask? task;
  // static var url;

  int votecount = 0;
  final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
  TextEditingController nameController = TextEditingController();
  TextEditingController phnoController = TextEditingController();

  DatabaseReference nameInstance =
      FirebaseDatabase.instance.ref().child("Name");

  DatabaseReference phnoInstance =
      FirebaseDatabase.instance.ref().child("Phno");
  Widget alertDialog() {
    return AlertDialog(
        title: const Text("Enter your details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(children: [
              Form(
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: const Icon(
                        Icons.person_outline,
                        color: Colors.blue,
                      ),
                      hintText: "Enter Your name...",
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(.18),
                          fontWeight: FontWeight.w900)),
                ),
              ),
              Form(
                child: TextFormField(
                  controller: phnoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: const Icon(
                        Icons.person_outline,
                        color: Colors.blue,
                      ),
                      hintText: "Enter Your Ph.no...",
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(.18),
                          fontWeight: FontWeight.w900)),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        var name = nameController.text;
                        var phno = phnoController.text;
                        await collectionInstance()
                            .set({'Name': name, 'phno': phno});
                        nameController.clear();
                        phnoController.clear();
                        Get.back();
                      },
                      child: const Text("Save")),
                )
              ])
            ])
          ],
        ));
  }

  var datas;
  gettinguserdetails() async {
    var document = FirebaseFirestore.instance
        .collection(AuthController.email!)
        .doc("userDetails");
    document.get().then((value) {
      datas = value['name'];
      update();
    });
  }

  Future profilePicker() async {
    final image = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (image == null) return;
    final path = image.files.single.path;
    update();
    file = File(path!);
    update();
  }

  Future savingProfile() async {
    if (file == null) return;
    final filename = basename(file!.path);
    final destination = '$datas/$datas profile';
    task = uploadTask(destination, file!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() => null);
    AuthController.url = await snapshot.ref.getDownloadURL();
    update();
  }

  static UploadTask? uploadTask(String destination, File file) {
    try {
      Reference storageReference = FirebaseStorage.instance.ref(destination);
      return storageReference.putFile(file);
    } on FirebaseException catch (e) {
      Get.snackbar("TryAgain", " Something went wrong",
          backgroundColor: Colors.blueAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Failed to upload",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          messageText: Text(e.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500)));
    }
  }

  Widget mydrawer() {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  accountEmail: Text(AuthController.email!.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      )),
                  accountName: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name : ${datas.toString().toUpperCase()}',
                          style: const TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                            onPressed: () {
                              Get.to(EditPage());
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ))
                      ],
                    ),
                  ),
                  currentAccountPicture: AuthController.url == null
                      ? GestureDetector(
                          onTap: () => Get.defaultDialog(
                              title: "Add Your ProfilePicture",
                              content: Column(
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blueAccent)),
                                    onPressed: () async {
                                      await profilePicker();
                                      savingProfile();
                                      Get.back();
                                      update();
                                    },
                                    child: Text(
                                      AuthController.url == null
                                          ? "Browse From Gallery"
                                          : "Change Image",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )),
                          child: const CircleAvatar(
                            child: Icon(Icons.image),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            await profilePicker();
                            savingProfile();
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              AuthController.url,
                            ),
                          ),
                        ),
                ),
                ListTile(
                    title: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueAccent)),
                        onPressed: () {
                          AuthController.instance.logout();
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            ),
          );
        });
  }
}
