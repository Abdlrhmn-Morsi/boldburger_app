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

  void deleteAllOrdersHistory() async {
    var order = await orders.get();
    for (var doc in order.docs) {
      await doc.reference.delete();
    }
  }
  void deleteAllFromCheckout() async {
    var check = await checkout.get();
    for (var doc in check.docs) {
      await doc.reference.delete();
    }
  }
  void updateProductIsLiked(Product burger, id) {
    getProductList.doc(id).update({'isLiked': isLiked = !isLiked});
  }

  void reomveFromFavorite(id) {
    getProductList.doc(id).update({'isLiked': isLiked = !isLiked});
  }

}









 