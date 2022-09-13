import '../../controller/dark_mode_controller.dart';

import '../../const/const.dart';
import '../../controller/search_controller.dart';
import 'custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomBtn extends StatelessWidget {
  double? width;
  double? height;
  String? text;
  double? fontSize;
  Color? colorText;
  dynamic onPressed;
  CustomBtn({
    Key? key,
    this.width,
    this.height,
    this.onPressed,
    required this.text,
    this.fontSize,
    this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DarkModeController darkModeController = Get.find();
    return MaterialButton(
      minWidth: width,
      height: height,
      color: darkModeController.getThemeFromBox()? colorIconDM : colorIconLM,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onPressed,
      child: CustomText(
        text: text,
        fontSize: fontSize,
        color: colorText,
      ),
    );
  }
}
