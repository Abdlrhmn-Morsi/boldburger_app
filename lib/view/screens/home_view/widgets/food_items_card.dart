import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../controller/crud_product_controller.dart';
import '../../../../controller/dark_mode_controller.dart';
import '../../../../controller/get_product_controller.dart';
import '../../../../const/const.dart';
import '../../../../model/product_model.dart';
import '../../details_view/details_view.dart';
import '../../../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodItemsCard extends StatelessWidget {
  GetProductController getProductController = Get.find();

  CrudProductController crudProductController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DarkModeController>(
      builder: (darkModeController) => FutureBuilder(
          future: getProductController.getProduct(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Product> burgers = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: burgers.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, i) {
                Product burger = burgers[i];

                return GestureDetector(
                  onTap: () {
                    Get.to(
                        transition: Transition.cupertino,
                        () => DetailsView(burger: burger, index: i));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, bottom: 20),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40),
                          height: 100,
                          decoration: BoxDecoration(
                            color: darkModeController.getThemeFromBox()
                                ? Colors.grey.shade900
                                : colorMain,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        //img
                        Positioned(
                            left: 15,
                            top: 0,
                            child: Hero(
                              tag: burger.title.toString(),
                              child: Container(
                                width: 90,
                                height: 90,
                                color: Colors.transparent,
                                child: Image.network(
                                  burger.img.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        //1th title
                        Positioned(
                          top: 17,
                          left: 110,
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.only(right: 200),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: burger.title,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: burger.description,
                                  fontSize: 14,
                                  color: darkModeController.getThemeFromBox()
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                  isMaxline: true,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '\$ ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: darkModeController
                                                  .getThemeFromBox()
                                              ? colorIconDM
                                              : colorText,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: burger.price.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: darkModeController
                                                  .getThemeFromBox()
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //btn
                        Positioned(
                          right: 5,
                          bottom: 0,
                          child: MaterialButton(
                            color: darkModeController.getThemeFromBox()
                                ? colorIconDM
                                : colorIconLM,
                            height: 35,
                            minWidth: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              // borderRadius: BorderRadius.only(
                              //   topLeft: Radius.circular(25),
                              //   topRight: Radius.circular(2),
                              //   bottomLeft: Radius.circular(2),
                              //   bottomRight: Radius.circular(10),
                              // ),
                            ),
                            onPressed: () {
                              crudProductController.addToCheckout(burger);
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
