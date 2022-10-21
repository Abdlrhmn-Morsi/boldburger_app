import 'package:boldburger/controller/auth_controller.dart';

import '../../../../controller/dark_mode_controller.dart';
import '../../../../const/const.dart';
import '../../../../controller/add_img_controller.dart';
import '../../favorite_view/favorite_view.dart';
import 'custom_chose_from_btm_sheet.dart';
import 'custom_drawer_item.dart';
import '../../orders_history_view/orders_view.dart';
import '../../../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List title = [
    ['Order History', 'assets/icons/shopping-bag.png'],
    ['Your favorite', 'assets/icons/heart.png'],
    ['Dark mode', 'assets/icons/night.png'],
    ['Promotions', 'assets/icons/tag.png'],
    ['Settings', 'assets/icons/setting.png'],
    ['Log out', 'assets/icons/power-off.png']
  ];

  @override
  Widget build(BuildContext context) {
    AddImgController imgController = Get.find();
    AuthController authController = Get.find();
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            DrawerHeader(
              child: GestureDetector(
                onTap: () {
                  showImgSorce(context);
                },
                child: Stack(
                  children: [
                    GetBuilder<AddImgController>(
                      builder: (controller) => ClipOval(
                        child: Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                              color: colorIconLM,
                              shape: BoxShape.circle,
                            ),
                            child: imgController.img == null
                                ? Image.asset(
                                    'assets/images/profile.png',
                                    fit: BoxFit.contain,
                                  )
                                : Image.file(
                                    imgController.img!,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 5,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: GetBuilder<DarkModeController>(
                          builder: (darkModeController) => const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomText(
              text: '@zacEvron',
              fontSize: 25,
            ),
            GetBuilder<DarkModeController>(
              builder: (darkModeController) => ListView.builder(
                shrinkWrap: true,
                itemCount: title.length,
                itemBuilder: (ctx, i) {
                  return CustomDrawerItem(
                    leading: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset(
                        title[i][1],
                        color: title[i][0] == 'Your favorite'
                            ? Colors.red
                            : title[i][0] == 'Log out'
                                ? Colors.red
                                : darkModeController.getThemeFromBox()
                                    ? Colors.white
                                    : Colors.black,
                      ),
                    ),
                    onTap: () {
                      if (title[i][0] == 'Log out') {
                        authController.signOut(context);
                      }

                      if (title[i][0] == 'Order History') {
                        Get.to(
                            transition: Transition.cupertino,
                            () => const OrdersHistoryView());
                      }
                      if (title[i][0] == 'Your favorite') {
                        Get.to(
                            transition: Transition.cupertino,
                            () => const FavoriteView());
                      }
                    },
                    title: title[i][0],
                    trailing: title[i][0] == 'Dark mode'
                        ? GetBuilder<DarkModeController>(
                            builder: (darkModeController) => Switch(
                              value: darkModeController.getThemeFromBox(),
                              activeColor: Colors.amber.shade700,
                              onChanged: (v) {
                                darkModeController.switchTheme();
                              },
                            ),
                          )
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
