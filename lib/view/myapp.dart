// ignore_for_file: avoid_print, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/controller/myapp_controller.dart';
import 'package:firebase_sample/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    gettinguserdetails();
  }

  var datas;
  gettinguserdetails() async {
    var document =
        FirebaseFirestore.instance.collection(widget.email!).doc("userDetails");
    document.get().then((value) {
      datas = value['name'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final collectionInstance = FirebaseFirestore.instance
        .collection(widget.email!)
        .doc("studetDetails");
    var controller =
        Get.put(Myappcontroller(collectionInstance: collectionInstance));

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
        .collection(widget.email!)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Model.fromJson(doc.data())).toList());

    return SafeArea(
      child: GetBuilder<Myappcontroller>(
          init: Myappcontroller(),
          builder: (controller) {
            return Scaffold(
                drawer: controller.mydrawer(),
                appBar: AppBar(

                ),
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
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: StreamBuilder<List<Model>>(
                          stream: readUsers(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(child: Text("Something went wrong"));
                            } else if (snapshot.hasData) {
                              final model = snapshot.data;
                              print(snapshot.data!.length);
                              return ListView(
                                children: model!.map(builduser).toList(),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      );
                    }));
          }),
    );
  }
}
