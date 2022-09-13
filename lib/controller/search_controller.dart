import '../model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'get_product_controller.dart';

GetProductController getProductController = Get.find();

class SearchController extends GetxController  {
  List<Product> cardIntroInfoList = [
    Product(
      title: "Best lunch",
      subtitle: 'Of the day',
      img: "assets/images/burgers_intro/black_burger.png",
    ),
    Product(
      title: "Best breakfast",
      subtitle: 'Of the day',
      img: "assets/images/burgers_intro/burger-big.png",
    ),
    Product(
      title: "Best dinner",
      subtitle: 'Of the day',
      img: "assets/images/burgers_intro/mini_burger.png",
    ),
  ];

  List<Product> filterdProducts = [];
  void searchFilter(String value) async {
    List<Product> allList = await getProductController.getProduct();
    if (value.isEmpty) {
      filterdProducts = allList;
    } else {
      filterdProducts = allList
          .where((e) => e.title!.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    }
    print('pressed from sraech ===searchFilter===');

    update();
  }

  @override
  void onInit() async {
    filterdProducts = await getProductController.getProduct();
    super.onInit();
  }
}
