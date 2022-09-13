import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddImgController extends GetxController {
  File? img;

  Future choseImgFrom(ImageSource source) async {
    try {
      final pickedImg = await ImagePicker().pickImage(source: source);
      if (pickedImg == null) return;
      final myImg = File(pickedImg.path);
      img = myImg;
    } on PlatformException catch (e) {
      print('faild to pick img :$e');
    }
    update();
  }
}
