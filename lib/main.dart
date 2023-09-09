import 'package:flutter/material.dart';
import 'package:forumapp/view/home_page.dart';
import 'package:forumapp/view/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // final box=GetStorage();
   
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
       final box=GetStorage();
      final token =box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forum App',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      token==null?const LoginPage():const HomePage(),
    );
  }
}

