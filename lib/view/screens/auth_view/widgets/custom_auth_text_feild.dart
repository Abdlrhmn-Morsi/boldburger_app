import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/const.dart';
import '../../../../controller/auth_controller.dart';

// ignore: must_be_immutable
class CustomAuthTextFiled extends StatelessWidget {
  bool isEmail;
  bool isVisible;
  bool isConfirmPassword;
  dynamic controller;
  CustomAuthTextFiled({
    Key? key,
    this.controller,
    this.isEmail = true,
    this.isVisible = true,
    this.isConfirmPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: TextFormField(
            controller: controller,
            validator: (v) {
              if (isEmail) {
                if (v!.isEmpty) {
                  return 'email must note be empty';
                } else if (!v.toString().contains('@') ||
                    !v.toString().contains('gmail.com')) {
                  return 'ex: example@gmail.com';
                }
              }

              if (!isConfirmPassword && !isEmail) {
                RegExp regExp = RegExp(r"(?=.*[a-z])(?=.[A-Z])\w+");
                if (v!.isEmpty) {
                  return 'password must note be empty';
                } else if (v.length < 8) {
                  return 'password must  be more than 8 characters';
                } else if (!v.toString().contains(regExp)) {
                  return 'Use Numbers and Capital and Small characters at least 1';
                }
              }

              if (isConfirmPassword && !isEmail) {
                RegExp regExp = RegExp(r"(?=.*[a-z])(?=.[A-Z])\w+");
                if (v!.isEmpty) {
                  return 'confirm password must note be empty';
                } else if (v != authController.signUPpasswordTextController.text) {
                  return 'password must  be same';
                } else if (v.length < 8) {
                  return 'password must  be more than 8 characters';
                } else if (!v.toString().contains(regExp)) {
                  return 'Use Numbers and Capital and Small characters at least 1';
                }
              }
              return null;
            },
            obscureText: isEmail
                ? false
                : isVisible
                    ? true
                    : false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              errorMaxLines: 1,
              isDense: true,
              contentPadding: const EdgeInsets.only(
                left: 14,
                right: 8,
                top: 8,
                bottom: 8,
              ),
              prefixIcon: isEmail
                  ? const Icon(Icons.email_outlined)
                  : isVisible
                      ? const Icon(Icons.lock)
                      : const Icon(Icons.lock),
              suffixIcon: isEmail
                  ? null
                  : isVisible
                      ? const Icon(Icons.visibility_rounded)
                      : const Icon(Icons.visibility_off),
              hintText: isEmail
                  ? 'example@gmail.com'
                  : isConfirmPassword
                      ? 'confirm password'
                      : 'password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: colorIconDM, width: 2)),
            ),
          ),
        ),
      ],
    );
  }
}
