import '../../../../controller/dark_mode_controller.dart';
import '../../../../const/const.dart';
import '../../../../controller/crud_product_controller.dart';
import '../../../../controller/get_product_controller.dart';
import '../../../../controller/price_controller.dart';
import '../../../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/product_model.dart';

class CheckoutCard extends StatelessWidget {
  GetProductController getProductController = Get.find();
  CrudProductController crudProductController = Get.find();
  DarkModeController darkModeController = Get.find();
  PriceController priceController = Get.find();

  CheckoutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getProductController.getCheckout(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Product> checkoutList = snapshot.data;

        return SizedBox(
          width: Get.width,
          height: Get.height -200,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: checkoutList.length,
            itemBuilder: (context, i) {
              Product burger = checkoutList[i];
              return Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: darkModeController.getThemeFromBox()
                      ? colorBgCardDM
                      : colorBgCardLM,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Dismissible(
                  background: Container(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 5,
                      top: 5,
                      bottom: 5,
                    ),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red.shade900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.white,
                    ),
                  ),
                  key: ValueKey(burger.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (directory) {
                    crudProductController.deleteFromCheckout(burger.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: darkModeController.getThemeFromBox()
                            ? colorBgCardDM
                            : colorBgCardLM,
                        content: CustomText(
                          text: 'Deleted',
                          fontSize: 18,
                          color: Colors.red.shade900,
                        ),
                      ),
                    );
                  },
                  child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //img
                        Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              color: Colors.transparent,
                              child: Image.network(
                                burger.img.toString(),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              width: 3,
                              height: 80,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        //content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //title
                            CustomText(
                              text: burger.title.toString(),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 15),
                            // quantity and increese and decreese
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        priceController.decresse(i);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: darkModeController
                                                  .getThemeFromBox()
                                              ? Colors.white
                                              : colorMain,
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GetBuilder<PriceController>(
                                      builder: (controllerPrice) => CustomText(
                                        text: controllerPrice
                                                    .productQuantity[i] ==
                                                null
                                            ? '0'
                                            : controllerPrice.productQuantity[i]
                                                .toString(),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),

                                    //incremenr
                                    GestureDetector(
                                      onTap: () {
                                        priceController.increment(burger, i);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: darkModeController
                                                  .getThemeFromBox()
                                              ? colorIconDM
                                              : colorIconLM,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        //delete and price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$ ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          darkModeController.getThemeFromBox()
                                              ? colorIconDM
                                              : colorText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: burger.price.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          darkModeController.getThemeFromBox()
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
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
