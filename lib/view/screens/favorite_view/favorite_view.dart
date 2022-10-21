import 'package:flutter_svg/svg.dart';

import '../../widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_text.dart';
import 'favorite_card.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          //app bar
          CustomAppBar(
            isHomeView: false,
            isCheckout: false,
            child: SvgPicture.asset(
              'assets/icons/heart.svg',
              color: Colors.red,
            ),
          ),
          //Orders title
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Your favorites ..',
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // checkout card
          const FavoriteCard(),
        ],
      ),
    );
  }
}
