import 'widgets/orders_card.dart';
import '../../widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_text.dart';

class OrdersHistoryView extends StatelessWidget {
  const OrdersHistoryView({Key? key}) : super(key: key);

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
            isCheckout: true,
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
                  text: 'Orders',
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Total',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    CustomText(
                      text: '\$55.80',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // checkout card
          const OrdersHistoryCard(),
        ],
      ),
    );
  }
}
