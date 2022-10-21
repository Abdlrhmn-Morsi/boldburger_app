import '../../../../controller/dark_mode_controller.dart';
import '../../../../const/const.dart';
import '../../../../controller/get_product_controller.dart';
import '../../../../model/product_model.dart';
import '../../../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersHistoryCard extends StatelessWidget {
  const OrdersHistoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetProductController getProductController = Get.find();

    DarkModeController darkModeController = Get.find();
    return StreamBuilder(
        stream: getProductController.getOrders(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Product> ordersList = snapshot.data;

          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: ordersList.length,
              itemBuilder: (context, i) {
                Product order = ordersList[i];

                return Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 5,
                    top: 5,
                    bottom: 5,
                  ),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: darkModeController.getThemeFromBox()
                        ? colorBgCardDM
                        : colorBgCardLM,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //img
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.transparent,
                          child: Image.network(
                            order.img.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 3,
                        height: 90,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      //content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //title
                          FittedBox(
                            child: CustomText(
                              text: order.title.toString(),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                              width: 22,
                              height: 22,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                order.productCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )),
                          const SizedBox(height: 5),
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
                                  text: order.price.toString(),
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
                      const Spacer(),
                      CustomText(
                        text: order.orderDateTime.toString(),
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
