import '../model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetProductController extends GetxController {
  final getProductList = FirebaseFirestore.instance.collection('product');
  final getCheckoutList = FirebaseFirestore.instance.collection('checkout');
  final grtordersList = FirebaseFirestore.instance.collection('orders');

  Future<List<Product>> getProduct() async {
    List<Product> burgersList = [];

    await getProductList.get().then(
          (v) => v.docs.map((doc) {
            burgersList.add(Product(
                id: doc.id,
                title: doc['title'],
                img: doc['img'],
                description: doc['description'],
                price: doc['price'],
                isLiked: doc['isLiked']));
          }).toList(),
        );

    return burgersList;
  }

  Stream<List<Product>> getCheckout() =>
      getCheckoutList.snapshots().map((snapshots) => snapshots.docs
          .map((doc) => Product(
                id: doc.id,
                title: doc['title'],
                img: doc['img'],
                description: doc['description'],
                price: doc['price'],
                productCount: doc['productCount'],
              ))
          .toList());

  Stream<List<Product>> getOrders() =>
      grtordersList.snapshots().map((snapshots) => snapshots.docs
          .map((doc) => Product(
                id: doc.id,
                title: doc['title'],
                img: doc['img'],
                price: doc['price'],
                orderDateTime: doc['orderDateTime'],
                productCount: doc['productCount'],
              ))
          .toList());

  Stream<List<Product>> updateFavorite() =>
      getProductList.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Product(
              id: doc.id,
              title: doc['title'],
              img: doc['img'],
              description: doc['description'],
              price: doc['price'],
              isLiked: doc['isLiked']))
          .toList());

  Stream<List<Product>> getFavorite() => getProductList
      .where('isLiked', isEqualTo: true)
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => Product(
                id: doc.id,
                title: doc['title'],
                img: doc['img'],
                description: doc['description'],
                price: doc['price'],
              ))
          .toList());

  @override
  void onInit() {
    getProduct();
    getCheckout();
    getFavorite();
    updateFavorite();
    super.onInit();
  }
}
