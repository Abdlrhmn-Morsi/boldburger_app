import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../const/const.dart';
import '../../../widgets/custom_text.dart';

class CustomAuthBtns extends StatelessWidget {
  bool isLogIn;
  dynamic onTapGoogle;
  dynamic onTapSign;
  CustomAuthBtns({
    Key? key,
    this.isLogIn = true,
    this.onTapGoogle,
    this.onTapSign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTapGoogle,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    color: Colors.red,
                    child: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CustomText(
                  text: 'Google Signin',
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTapSign,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorIconDM,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: CustomText(
                text: isLogIn ? 'Login' : 'Signup',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}