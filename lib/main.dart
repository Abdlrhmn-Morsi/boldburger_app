import 'package:boldburger/view/screens/auth_view/auth_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'controller/dark_mode_controller.dart';
import 'controller/injection.dart';
import 'view/screens/home_view/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Injection();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DarkModeController darkModeController = Get.find();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Burger App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: darkModeController.theme,
      home: FirebaseAuth.instance.currentUser != null
          ? HomeView()
          : const AuthView(),
    );
  }
}
