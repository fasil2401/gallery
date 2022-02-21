import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gallery/model/db_model.dart';
import 'package:gallery/widgets/grid_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<DBModel> box = Hive.box<DBModel>('storage');

  dynamic _imagepath;
  XFile? _image;
   File? directoryFile;
   var externaldir;
   String? externaldirPath;

   makeStorage() async{
    externaldir = await getExternalStorageDirectory();
    String newPath = "";
    List<String> directoryList = externaldir!.path.split('/');
    for(int i=1;i<directoryList.length;i++){
      String tempPath = directoryList[i];
      if(directoryList[i]!='Android'){
        newPath += "/"+tempPath;
      }else{break;}
    }
    newPath += "/CustomGallery";
    externaldir = Directory(newPath);
    externaldirPath = externaldir.path;
    if(!await externaldir.exists()){
      await externaldir.create(recursive: true);
    }
  }

  Future getImage() async {
    // Directory directory = await getApplicationDocumentsDirectory();
    // String directoryPath = directory.path;
    ImagePicker _imagePicker = ImagePicker();
    _image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (_image != null) {
      final path = basename(_image!.path);
      final File file = await File(_image!.path).copy('$externaldirPath/$path');
      setState(() {
        _imagepath = file.path;
        box.add(DBModel(path: _imagepath));
      });
    }
    return null;
  }

  getPermission() async {
    var checkStatus = await Permission.camera.status;
    if (!checkStatus.isGranted) {
      await Permission.camera.request();
    }
    if (checkStatus.isGranted) {
     getPermissionStorage();
    } else {
      const SnackBar(
        content: Text(
          "Please enable camera permission to continue",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

 getPermissionStorage()async{
   var storagePermission = await Permission.storage.status;
   var managePermission = await Permission.manageExternalStorage.status;
   var mediaPermission = await Permission.accessMediaLocation.status;
   if(storagePermission.isGranted && managePermission.isGranted && mediaPermission.isGranted){
    await makeStorage();
     if(await externaldir.exists()){
       getImage();
     }
   }else if(storagePermission.isDenied||managePermission.isDenied||mediaPermission.isDenied){
     await Permission.storage.request();
     await Permission.accessMediaLocation.request();
     await Permission.manageExternalStorage.request();
     if(storagePermission.isGranted && managePermission.isGranted){
       makeStorage();
       if(await externaldir.exists()){
         getImage();
       }
     }
   }else{
     const SnackBar(content: Text("Please enable storage permission to continue",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,);
     openAppSettings();
   }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 227, 225),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Gallery',
          style: GoogleFonts.dancingScript(
              fontWeight: FontWeight.w700, fontSize: 35),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (BuildContext context, Box<DBModel> newbox, Widget? child) {
          List key = newbox.keys.toList();
          return key.isEmpty
              ? const Center(
                  child: Text(
                    "Click images",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: key.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    List<DBModel> images = newbox.values.toList();
                    final data = images[index];
                    return ImageTile(
                      imagepath: data.path,
                      index: index,
                      imagebox: images,
                      value: data,
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingCustom(
        onpressed: () {
          getPermission();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
