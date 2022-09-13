import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarBtns extends StatelessWidget {
  dynamic iconImg;
  dynamic onPressed;
  AppBarBtns({
    Key? key,
    required this.iconImg,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: GestureDetector(
        onTap: onPressed,
        child: Stack(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              child: Image.asset(
                iconImg,
                color: Colors.white,
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
