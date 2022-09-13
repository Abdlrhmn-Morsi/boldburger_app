import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/const.dart';
import '../../../../controller/dark_mode_controller.dart';
import '../../../../model/product_model.dart';
import '../../../widgets/custom_text.dart';

class CustomSearchItems extends StatelessWidget {
  Product burger;
  CustomSearchItems({
    Key? key,
    required this.burger,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DarkModeController darkModeController = Get.find();
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //img
          Hero(
            tag: burger.title.toString(),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.all(8),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: darkModeController.getThemeFromBox()
                    ? Colors.white
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Image.network(
                burger.img.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              CustomText(
                text: burger.title,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              //subtitle
              CustomText(
                text: 'Classic Hamburger',
                fontSize: 16,
                color: darkModeController.getThemeFromBox()
                    ? Colors.grey.shade400
                    : Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
              //price
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$ ',
                      style: TextStyle(
                        fontSize: 16,
                        color: darkModeController.getThemeFromBox()
                            ? colorIconDM
                            : colorText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: burger.price.toString(),
                      style: TextStyle(
                        color: darkModeController.getThemeFromBox()
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
