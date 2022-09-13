import 'package:flutter/cupertino.dart';

import '../model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CrudProductController extends GetxController {
  var checkout = FirebaseFirestore.instance.collection('checkout');
  var orders = FirebaseFirestore.instance.collection('orders');
  final getProductList = FirebaseFirestore.instance.collection('product');
  bool isLiked = false;

  void addOrdersList() async {
    List<Product> ordersList = await checkout.get().then((value) => value.docs
        .map(
          (doc) => Product(
            id: doc.id,
            title: doc['title'],
            img: doc['img'],
            price: doc['price'],
            productCount: doc['productCount'],
            orderDateTime: doc['orderDateTime'],
          ),
        )
        .toList());
    for (var pro in ordersList) {
      orders.add(pro.toMap());
    }
    Product test = Product(
      totalPrice: 180,
      orderDateTime:
          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    );
    orders.doc('total').set(test.toMap());
  }

  void addToCheckout(Product burger) {
    Product checkoutList = Product(
      title: burger.title,
      description: burger.description,
      price: burger.price,
      img: burger.img,
      productCount: burger.productCount,
      orderDateTime:
          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    );
    checkout.add(checkoutList.toMap());
  }

  void deleteFromCheckout(id) {
    checkout.doc(id).delete();
  }

  void updateProductIsLiked(Product burger, id) {
    getProductList.doc(id).update({'isLiked': isLiked = !isLiked});
  }

  void reomveFromFavorite(id) {
    getProductList.doc(id).update({'isLiked': isLiked = !isLiked});
  }

  @override
  void onInit() {
    // getCheckoutListTest();
    super.onInit();
  }
}









 // Future<List<Product>> getCheckoutListTest() async {
  //   List<Product> checkoutList = [];
  //   await checkout.get().then(
  //         (v) => v.docs.map((doc) {
  //           checkoutList.add(Product(
  //               id: doc.id,
  //               title: doc['title'],
  //               img: doc['img'],
  //               description: doc['description'],
  //               price: doc['price'],
  //               isLiked: doc['isLiked']));
  //         }).toList(),
  //       );

  //   return checkoutList;
  // }

  // productQuantity(Product product, index) async {
    // List<Product> checkoutList = await getCheckoutListTest();
    // checkoutList.map((e) =>
    //     checkoutList.isEmpty ? addToCheckout(product) : addToCheckout(product));

    // if (checkoutList.isEmpty || checkoutList[index].title == product.title) {
    //   print('nonoooooooooooooo');
    // } else if () {

    // } else {
    //   print('error');
    // }
    // print('${checkoutList.length}============');
    // update();
  // }