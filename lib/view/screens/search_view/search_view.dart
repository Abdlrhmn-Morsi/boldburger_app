import '../../../model/product_model.dart';

import '../../../const/const.dart';
import '../../../controller/search_controller.dart';
import '../details_view/details_view.dart';
import 'widgets/custom_search_items.dart';
import '../../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/get_product_controller.dart';

// ignore: must_be_immutable
class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  GetProductController getProductController = Get.find();
  SearchController searchController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 70),
          //search bar
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    autofocus: false,
                    cursorColor: Colors.black,
                    onChanged: (v) {
                      searchController.searchFilter(v);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          //content
          Expanded(
            child: FutureBuilder(
                future: getProductController.getProduct(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GetBuilder<SearchController>(
                    builder: (searchController) => ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: searchController.filterdProducts.length,
                      itemBuilder: (context, i) {
                        Product burger = searchController.filterdProducts[i];
                        return GestureDetector(
                            onTap: () {
                              Get.to(
                                  transition: Transition.cupertino,
                                  () => DetailsView(burger: burger, index: i));
                            },
                            child: CustomSearchItems(burger: burger));
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
