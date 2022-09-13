import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DarkModeController extends GetxController{
 RxBool seeAll = RxBool(false);
///////////////DARK MODE//////////////////////////////////
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemeInBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool getThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => getThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(getThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeInBox(!getThemeFromBox());
    update();
  }
}