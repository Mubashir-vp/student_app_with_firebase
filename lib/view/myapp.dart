// ignore_for_file: avoid_print, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/controller/auth_controller.dart';
import 'package:firebase_sample/controller/myapp_controller.dart';
import 'package:firebase_sample/model/model.dart';
import 'package:firebase_sample/model/studentsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'editpage.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({Key? key, this.email}) : super(key: key);
  String? email;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final collectionInstance = FirebaseFirestore.instance
        .collection(widget.email!)
        .doc("studetDetails");

    instance({var text}) {
      return FirebaseFirestore.instance
          .collection(AuthController.email)
          .doc("studentdetails")
          .collection(text);
    }

    var controller =
        Get.put(Myappcontroller(collectionInstance: collectionInstance));

    Widget buuildStudent(StudentModel studentModel) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ListTile(
            leading: CircleAvatar(
              child: Text(
                studentModel.age!.toString(),
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
            title: Text(
              studentModel.name!,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueAccent),
            ),
            subtitle: Text(
              studentModel.department!,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueAccent),
            ),
           trailing: Text(
            studentModel.schoolname!,
            style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent),
          ),),
      );
    }

    Widget builduser(Model model) {
      return ListTile(
        leading: Text(model.name ?? "error occured"),
        trailing: Text(model.age.toString()),
      );
    }

    Stream<List<Model>> readUsers() => FirebaseFirestore.instance
        .collection(widget.email!)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Model.fromJson(doc.data())).toList());

    Stream<List<Model>> readStudents() => FirebaseFirestore.instance
        .collection("StudentApp")
        .doc(AuthController.email)
        .collection("studentdetails")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Model.fromJson(doc.data())).toList());

    return SafeArea(
      child: GetBuilder<Myappcontroller>(
          id: "myapp",
          init: Myappcontroller(),
          builder: (controller) {
            return Scaffold(
                drawer: controller.mydrawer(),
                appBar: AppBar(),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        builder: (BuildContext context) {
                          return controller.alertDialog();
                        },
                        context: context);
                  },
                  child: const Text("Add"),
                ),
                backgroundColor: Colors.amber[50],
                body: GetBuilder<Myappcontroller>(
                    init: Myappcontroller(),
                    builder: (controller) {
                      return StreamBuilder<List<StudentModel>>(
                        stream: controller.readStudents(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Center(
                                child: Text("Something went wrong",
                                    style: TextStyle(
                                      color: Colors.red,
                                    )));
                          } else if (snapshot.hasData) {
                            final studentModel = snapshot.data;
                            return ListView(
                              children:
                                  studentModel!.map(buuildStudent).toList(),
                            );
                          } else if (snapshot.data == null) {
                            return const Center(
                              child: Text(
                                "Database is empty",
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
                    }));
          }),
    );
  }
}
