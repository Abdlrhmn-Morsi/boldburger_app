import 'package:boldburger/view/screens/auth_view/auth_view.dart';
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

  Future googleSign(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );
      final googleAccount = await GoogleSignIn().signIn();
      user = googleAccount;

      final googleAuth = await googleAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential);

      Get.to(() => HomeView());
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.message.toString()),
        ),
      );
    }
    update();
  }

  //AACA
//acount / auth / credencial / auth

  Future signUPwithEmailANDpassword(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );
      await auth.createUserWithEmailAndPassword(
        email: signUPemailTextController.text,
        password: signUPpasswordTextController.text,
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.message.toString()),
        ),
      );
    }
    update();

    if (auth.currentUser != null && !auth.currentUser!.emailVerified) {
      await auth.currentUser!.sendEmailVerification();
    }

    Get.to(() => HomeView());
  }

  Future signINwithEmailANDpassword(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );
      await auth.signInWithEmailAndPassword(
        email: signINemailTextController.text,
        password: signINpasswordTextController.text,
      );

      Get.to(() => HomeView());
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.message.toString()),
        ),
      );
    }
    update();
  }

  void signOut(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );
      await auth.signOut();
      Get.to(() => const AuthView());
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.message.toString()),
        ),
      );
    }
    update();
  }
}
