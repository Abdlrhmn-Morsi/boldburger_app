import 'dart:ui';

import 'package:boldburger/controller/crud_product_controller.dart';
import 'package:boldburger/view/screens/orders_history_view/orders_view.dart';

import '../../../controller/dark_mode_controller.dart';
import '../../../controller/price_controller.dart';
import 'widgets/checkout_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import '../../../const/const.dart';
import '../../widgets/custom_text.dart';
import 'package:get/get.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  DarkModeController darkModeController = Get.find();
  CrudProductController crudProductController = Get.find();
  PriceController priceController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: CustomAppBar(
                isHomeView: false,
                isCheckout: true,
              ),
            ),
            //checkout title
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomText(
                  text: 'Checkout',
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // checkout card
            CheckoutCard(),
            // total price and btn
            Spacer(),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        child: SizedBox(
          height: 110,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Total price',
                          fontSize: 22,
                          color: Colors.grey.shade100,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 5),
                        GetBuilder<PriceController>(
                          builder: (priceController) => RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '\$',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: darkModeController.getThemeFromBox()
                                        ? colorIconDM
                                        : colorText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: priceController.totalPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: darkModeController.getThemeFromBox()
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomBtn(
                      text: 'Checkout',
                      colorText: Colors.white,
                      fontSize: 20,
                      height: 60,
                      width: 160,
                      onPressed: () {
                        crudProductController.addOrdersList();
                      Get.to(
                          transition: Transition.cupertino,
                          () => const OrdersHistoryView());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
