import 'package:flutter/material.dart';



class CustomText extends StatelessWidget {
  String? text;
  Color? color;
  double? fontSize;
  dynamic fontWeight;
  bool isMaxline;
  CustomText(
      {Key? key,
      this.isMaxline = false,
      this.fontWeight,
      required this.text,
      this.color,
      this.fontSize = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: isMaxline ? 2 : null,
      overflow: isMaxline ? TextOverflow.ellipsis : null,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
