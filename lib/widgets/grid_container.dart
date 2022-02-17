import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery/screens/view.dart';
import '../model/db_model.dart';
// import 'package:gallery/screens/home_screen.dart';

class ImageTile extends StatelessWidget {
  final dynamic imagepath;
  final List<DBModel> imagebox;
  final int index;
  final value;
  const ImageTile(
      {Key? key,
      required this.value,
      required this.imagepath,
      required this.index,
      required this.imagebox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: GestureDetector(
          onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ViewImage(data: imagebox, index: index,)));
          },
          child: Container(           
            padding:const EdgeInsets.all(50),
               
             child: ClipRRect(
               borderRadius: BorderRadius.circular(100),
               child: Image.file(File(imagepath),
               height: 700,),

               ),
             )
          ),
    );
  }
}
class FloatingCustom extends StatelessWidget {
  VoidCallback onpressed;
   FloatingCustom({Key? key,required this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
        child:const Icon(Icons.camera),
        onPressed: onpressed,
    );
    
  }
}