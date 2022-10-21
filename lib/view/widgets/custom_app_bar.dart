import 'package:boldburger/controller/crud_product_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/dark_mode_controller.dart';
import '../../const/const.dart';
import '../../controller/add_img_controller.dart';
import '../../model/product_model.dart';
import 'custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  dynamic OnTapFavorite;
  Product? burgerLiked;
  bool isHomeView;
  Widget? child;
  bool? isDeleteFromOrderHistory;

  bool isCheckout;
  CustomAppBar({
    Key? key,
    this.isDeleteFromOrderHistory = false,
    this.child,
    this.OnTapFavorite,
    this.burgerLiked,
    this.isCheckout = false,
    this.isHomeView = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DarkModeController darkModeController = Get.find();
    CrudProductController crudProductController = Get.find();
    return Container(
      width: Get.width,
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 20, top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isHomeView
                ? Builder(
                    builder: (context) => IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: GetBuilder<DarkModeController>(
                          builder: (darkModeController) => Image.asset(
                            'assets/icons/more.png',
                            color: darkModeController.getThemeFromBox()
                                ? Colors.white
                                : Colors.black,
                            width: 30,
                            height: 30,
                          ),
                        )),
                  )
                : IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
            isHomeView
                ? GetBuilder<DarkModeController>(
                    builder: (controller) => Text(
                      'Bold Burger',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 31,
                        color: controller.getThemeFromBox()
                            ? colorIconDM
                            : colorIconLM,
                      ),
                    ),
                  )
                : Container(),
            isHomeView
                ? GetBuilder<AddImgController>(
                    builder: (controller) => ClipOval(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: colorIconLM,
                          shape: BoxShape.circle,
                        ),
                        child: controller.img == null
                            ? Image.asset(
                                'assets/images/profile.png',
                                fit: BoxFit.contain,
                              )
                            : Image.file(
                                controller.img!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  )
                : isCheckout
                    ? IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          isDeleteFromOrderHistory!
                              ? crudProductController.deleteAllOrdersHistory()
                              : crudProductController.deleteAllFromCheckout();
                        },
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                          size: 30,
                        ),
                      )
                    : GestureDetector(
                        onTap: OnTapFavorite,
                        child: SizedBox(width: 30, height: 30, child: child),
                      )
          ],
        ),
      ),
    );
  }
}
