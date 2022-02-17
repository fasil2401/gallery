import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery/model/db_model.dart';
// import 'package:hive_flutter/adapters.dart';

class ViewImage extends StatelessWidget {
  final List<DBModel> data;
  final int index;

  const ViewImage({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(data[index].path),
                        height: 500,
                      ),
                    ),
                  )),
            ),
          ),
        ],
      )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: FloatingActionButton(
          backgroundColor:const Color.fromARGB(255, 117, 107, 107),
          foregroundColor:const Color.fromARGB(255, 165, 13, 2),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Delete"),
                    content: const Text("Do you want to delete?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No")),
                      TextButton(
                          onPressed: () {
                            data[index].delete();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Yes")),
                    ],
                  );
                });
          },
          child: const Icon(Icons.delete),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
