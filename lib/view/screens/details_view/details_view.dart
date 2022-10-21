import 'package:boldburger/controller/get_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../const/const.dart';
import '../../../controller/crud_product_controller.dart';
import '../../../controller/dark_mode_controller.dart';
import '../../../model/product_model.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_btn.dart';
import '../../widgets/custom_text.dart';
import '../checkout_view/checkout_view.dart';

class DetailsView extends StatefulWidget {
  Product burger;

  dynamic index;
  DetailsView({
    Key? key,
    this.index,
    required this.burger,
  }) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  DarkModeController darkModeController = Get.find();
  CrudProductController crudProductController = Get.find();
  GetProductController getProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream: getProductController.updateFavorite(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<Product> isLiked = snapshot.data;
                  return CustomAppBar(
                    isHomeView: false,
                    burgerLiked: widget.burger,
                    OnTapFavorite: () {
                      crudProductController.updateProductIsLiked(
                          widget.burger, widget.burger.id);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/heart.svg',
                      color: isLiked[widget.index].isLiked!
                          ? Colors.red
                          : Colors.grey,
                    ),
                  );
                }),

            //img
            Hero(
              tag: widget.burger.title.toString(),
              child: Container(
                alignment: Alignment.center,
                height: Get.height / 2.6,
                child: Image.network(widget.burger.img.toString()),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CustomText(
                text: widget.burger.title,
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ),
            const SizedBox(height: 5),
            //subtitle
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CustomText(
                text: 'Burger with extra chicken',
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 5),
            //descreption
            GetX<DarkModeController>(
              builder: (controller) => Container(
                child: controller.seeAll.value
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: CustomText(
                          color: darkModeController.getThemeFromBox()
                              ? Colors.grey.shade300
                              : Colors.grey.shade500,
                          fontSize: 18,
                          text: widget.burger.description,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 50,
                          child: CustomText(
                            color: darkModeController.getThemeFromBox()
                                ? Colors.grey.shade300
                                : Colors.grey.shade500,
                            fontSize: 18,
                            text: widget.burger.description,
                            isMaxline: true,
                          ),
                        ),
                      ),
              ),
            ),

            //see all
            GetX<DarkModeController>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    controller.seeAll.value = !controller.seeAll.value;
                  },
                  child: CustomText(
                    color: darkModeController.getThemeFromBox()
                        ? colorIconDM
                        : colorIconLM,
                    fontSize: 16,
                    text: controller.seeAll.value ? 'see less' : 'see more..',
                    isMaxline: true,
                  ),
                ),
              ),
            ),
            const Spacer(),
            // price and add to card btn
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Price',
                        fontSize: 22,
                        color: darkModeController.getThemeFromBox()
                            ? colorIconDM
                            : Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$ ',
                              style: TextStyle(
                                fontSize: 22,
                                color: darkModeController.getThemeFromBox()
                                    ? colorIconDM
                                    : colorText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.burger.price.toString(),
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
                    ],
                  ),
                  CustomBtn(
                    text: 'Add To Cart',
                    colorText: Colors.white,
                    fontSize: 20,
                    height: 70,
                    width: 180,
                    onPressed: () {
                      crudProductController.addToCheckout(widget.burger);
                      Get.to(
                          transition: Transition.cupertino,
                          () => const CheckoutView());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
