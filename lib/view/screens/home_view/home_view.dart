import 'package:boldburger/controller/get_product_controller.dart';

import '../../../controller/dark_mode_controller.dart';

import '../../../const/const.dart';
import '../../../model/product_model.dart';
import '../checkout_view/checkout_view.dart';
import 'widgets/appbar_btns.dart';
import 'widgets/food_category.dart';
import '../search_view/search_view.dart';
import 'widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/food_intro_card.dart';
import 'widgets/food_items_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  GetProductController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAppBar(),
            const SizedBox(height: 10),
            //body
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // app title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //header
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CustomText(
                            text: 'What do you like\nto eat?',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        //btns
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //search
                            AppBarBtns(
                              iconImg: 'assets/icons/search.png',
                              onPressed: () {
                                Get.to(
                                  transition: Transition.cupertino,
                                  () => SearchView(),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            //shopping
                            Stack(
                              children: [
                                AppBarBtns(
                                  iconImg: 'assets/icons/bag.png',
                                  onPressed: () {
                                    Get.to(
                                      transition: Transition.cupertino,
                                      () => const CheckoutView(),
                                    );
                                  },
                                ),
                                Positioned(
                                  top: 0,
                                  right: 20,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                    child: StreamBuilder(
                                        stream: controller.getCheckout(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          List<Product> checkoutList =
                                              snapshot.data;
                                          return CustomText(
                                            text:
                                                checkoutList.length.toString(),
                                            fontSize: 14,
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    //food intro
                    FoodIntroCard(),
                    const FoodCategory(),
                    const SizedBox(height: 2),
                    // title
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Popular Food',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          GetBuilder<DarkModeController>(
                            builder: (darkModeController) => CustomText(
                              text: 'See All',
                              color: darkModeController.getThemeFromBox()
                                  ? colorIconDM
                                  : colorText,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    //food items
                    FoodItemsCard(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
