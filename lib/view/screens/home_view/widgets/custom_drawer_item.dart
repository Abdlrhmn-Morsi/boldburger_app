import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDrawerItem extends StatelessWidget {
  IconData? icon;
  Color? iconColor;
  double? iconSize;

  String title;
  Color? titleColor;
  double? titleSize;

  String? subtitle;
  Color? subtitleColor;
  double? subtitleSize;
  dynamic leading;
  Widget? trailing;

  VoidCallback onTap;

  CustomDrawerItem({
    Key? key,
    required this.leading,
    this.icon,
    this.iconColor,
    this.iconSize,
    required this.title,
    this.titleColor,
    this.titleSize,
    this.subtitle,
    this.subtitleColor,
    this.subtitleSize,
    this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: titleColor),
        maxLines: 1,
      ),
      // subtitle: Text(
      //   subtitle!,
      //   style: TextStyle(color: subtitleColor),
      //   maxLines: 1,
      // ),
      trailing: (trailing != null)
          ? trailing
          : const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
