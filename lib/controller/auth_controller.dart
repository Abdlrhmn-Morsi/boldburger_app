import '../view/screens/home_view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final signINemailTextController = TextEditingController();
  final signINpasswordTextController = TextEditingController();
  final signUPemailTextController = TextEditingController();
  final signUPpasswordTextController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignInAccount? user;
  RxBool isLoading = false.obs;

  Future googleSign() async {
    isLoading = true.obs;

    final googleAccount = await GoogleSignIn().signIn();
    user = googleAccount;

    final googleAuth = await googleAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential);
    isLoading = false.obs;
    Get.to(() => HomeView());
  }

  //AACA
//acount / auth / credencial / auth

  Future signUPwithEmailANDpassword() async {
    try {
      isLoading = true.obs;

      final credential = await auth.createUserWithEmailAndPassword(
        email: signUPemailTextController.text,
        password: signUPpasswordTextController.text,
      );

      isLoading = false.obs;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      Get.snackbar('error', e.toString(), colorText: Colors.red);
    }

    if (auth.currentUser != null && !auth.currentUser!.emailVerified) {
      await auth.currentUser!.sendEmailVerification();
    }

    Get.to(() => HomeView());
  }

  Future signINwithEmailANDpassword() async {
    try {
      isLoading = true.obs;

      await auth.signInWithEmailAndPassword(
        email: signINemailTextController.text,
        password: signINpasswordTextController.text,
      );

      isLoading = false.obs;
      Get.to(() => HomeView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('error', e.toString(), colorText: Colors.red);
    }
  }
}
