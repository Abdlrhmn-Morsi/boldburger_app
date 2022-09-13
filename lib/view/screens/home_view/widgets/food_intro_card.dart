import '../../../../controller/dark_mode_controller.dart';

import '../../../../const/const.dart';
import '../../../../controller/search_controller.dart';
import '../../../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FoodIntroCard extends StatelessWidget {
  FoodIntroCard({
    Key? key,
  }) : super(key: key);

  SearchController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DarkModeController>(
      builder: (darkModeController) => Container(
        color: Colors.transparent,
        width: Get.width,
        height: 165,
        child: ListView.builder(
            padding: const EdgeInsets.only(left: 0, top: 0),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.cardIntroInfoList.length,
            itemBuilder: (context, i) {
              var intro = controller.cardIntroInfoList[i];
              return Container(
                margin: const EdgeInsets.only(left: 20),
                width: 330,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: 280,
                      height: 160,
                      decoration: BoxDecoration(
                        color: darkModeController.getThemeFromBox()
                            ? colorBgCardDM
                            : colorBgCardLM,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //1th title
                          CustomText(
                            text: intro.title,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          //2th title
                          CustomText(
                            text: intro.subtitle,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(height: 15),
                          //btn
                          MaterialButton(
                            color: Colors.black,
                            height: 40,
                            minWidth: 80,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {},
                            child: CustomText(
                              text: 'EAT',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //img
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 10,
                      child: Container(
                        width: 170,
                        height: 170,
                        color: Colors.transparent,
                        child: Image.asset(
                          intro.img.toString(),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
