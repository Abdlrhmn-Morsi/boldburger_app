// import 'package:burger_app/view/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CustomTapBar extends StatefulWidget {
//   const CustomTapBar({Key? key}) : super(key: key);

//   @override
//   State<CustomTapBar> createState() => _CustomTapBarState();
// }

// class _CustomTapBarState extends State<CustomTapBar>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController = TabController(length: 4, vsync: this);
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           TabBar(
//             padding: const EdgeInsets.all(0),
//             controller: tabController,
//             indicatorColor: Colors.black,
//             labelColor: Colors.greenAccent,
//             unselectedLabelColor: Colors.black,
//             tabs: const [
//               Tab(
//                 text: 'BURGER',
//               ),
//               Tab(
//                 text: 'PIZZA',
//               ),
//               Tab(
//                 text: 'SANDWICH',
//               ),
//               Tab(
//                 text: 'SALAD',
//               ),
//             ],
//           ),
//           Container(
//             color: Colors.grey.shade300,
//             height: 200,
//             width: Get.width,
//             child: TabBarView(
//               controller: tabController,
//               children: [
//                 CustomText(text: 'BURGER'),
//                 CustomText(text: 'PIZZA'),
//                 CustomText(text: 'SANDWICH'),
//                 CustomText(text: 'SALAD'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
