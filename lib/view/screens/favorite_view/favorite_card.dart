import 'package:boldburger/model/product_model.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../controller/dark_mode_controller.dart';
import '../../../../const/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/crud_product_controller.dart';
import '../../../controller/get_product_controller.dart';
import '../../widgets/custom_text.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DarkModeController darkModeController = Get.find();
    GetProductController getProductController = Get.find();
    CrudProductController crudProductController = Get.find();
    return StreamBuilder(
        stream: getProductController.getFavorite(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Product> favorites = snapshot.data;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: favorites.length,
              itemBuilder: (context, i) {
                Product favorite = favorites[i];

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
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 70,
                              height: 70,
                              color: Colors.transparent,
                              child: Image.network(
                                favorite.img.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: 3,
                            height: 90,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      //content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //title
                          FittedBox(
                            child: CustomText(
                              isMaxline: true,
                              text: favorite.title.toString(),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          //price
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '\$ ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: darkModeController.getThemeFromBox()
                                        ? colorIconDM
                                        : colorText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: favorite.price.toString(),
                                  style: TextStyle(
                                    color: darkModeController.getThemeFromBox()
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //favorite icons
                          GestureDetector(
                            onTap: () {
                              crudProductController
                                  .reomveFromFavorite(favorite.id);
                            },
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: SvgPicture.asset(
                                'assets/icons/heart.svg',
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          //date
                          CustomText(
                            text: '17/8/2021',
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
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
