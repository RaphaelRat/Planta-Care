import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import './app/modules/bottom_navigation/bottom_navigation_page.dart';
import './app/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromRGBO(196, 246, 234, 0.5), // navigation bar color
      statusBarColor: Color.fromRGBO(33, 183, 146, 1), // status bar color
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Redes sem fios',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: BottomNavigationPage.route,
      getPages: getAppPages(),
    );
  }
}
