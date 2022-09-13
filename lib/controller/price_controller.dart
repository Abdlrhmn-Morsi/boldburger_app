import 'package:get/get.dart';
import '../model/product_model.dart';
import 'get_product_controller.dart';

GetProductController getProductController = Get.find();

class PriceController extends GetxController {
  int totalPrice = 0;
  int productCount = 0;
  int holdPrice = 0;
  List<Product> _product = [];
  List<ProductItem> _productCount = [];

  Map productQuantity = <int, int>{};

  void increment(Product product, int index) {
    if (productQuantity[index] == null) {
      productQuantity[index] = 0;
    } else {
      productQuantity[index] ++;
      productQuantity.forEach((key, value) {
        
        totalPrice = ( value*product.price!)+totalPrice ;
      });

      // totalPrice = productQuantity[index] + productQuantity[index]*product.price;
    }
    update();
  }

  void decresse(int index) {
    if (productQuantity[index] <= 0) {
      Get.snackbar('BoldBurger', 'can not decrement');
    } else {
      productQuantity[index] -= 1;
    }
    update();
  }
}

class ProductItem {
  int quantity;

  ProductItem({this.quantity = 1});
}
