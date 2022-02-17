import 'package:flutter/material.dart';
import 'package:gallery/model/db_model.dart';
import 'package:gallery/screens/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
 Hive.registerAdapter(DBModelAdapter());
await Hive.openBox<DBModel>('storage');

  // await Hive.initFlutter();
  // Hive.registerAdapter(ModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}



