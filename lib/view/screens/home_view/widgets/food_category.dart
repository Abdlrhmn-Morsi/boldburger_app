import '../../../../controller/dark_mode_controller.dart';

import '../../../../const/const.dart';
import '../../../../controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodCategory extends StatefulWidget {
  const FoodCategory({Key? key}) : super(key: key);

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

var myi = 0;

class _FoodCategoryState extends State<FoodCategory> {
  @override
  Widget build(BuildContext context) {
    SearchController controller = Get.find();
    return SizedBox(
      width: Get.width,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, i) {
          return Padding(
            padding: i == 0
                ? const EdgeInsets.only(left: 10)
                : const EdgeInsets.only(left: 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  myi = i;
                });
              },
              child: GetBuilder<DarkModeController>(
                builder: (controller) => Container(
                  margin: const EdgeInsets.all(8),
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == myi
                        ? controller.getThemeFromBox()
                            ? colorCatActiveDM
                            : colorCatActiveLM
                        :controller.getThemeFromBox()?colorCatNotActiveDM: colorCatNotActiveLM,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:controller.getThemeFromBox()?Colors.black: colorBgCardLM,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7, left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/burgers_intro/black_burger.png',
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(width: 5),
                        const Text('burger'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
