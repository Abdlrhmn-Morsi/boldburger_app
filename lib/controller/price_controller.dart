import 'package:boldburger/controller/crud_product_controller.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';

class PriceController extends GetxController {
  CrudProductController crudProductController = CrudProductController();
  int totalPrice = 0;
  int totalPriceFunction() {
    update();
    return totalPrice;
  }

  void increment({List<Product>? products, Product? product, int? index}) {
    totalPrice = 0;

    if (product!.quantity >= 1) {
      product.quantity++;
      product.currentPrince = product.quantity * product.price!;
    }
    for (var e in products!) {
      totalPrice += e.quantity * e.price!;
    }

    update();
  }

  void decresse(List<Product> products, Product product, int index) {
    totalPrice = 0;

    if (product.quantity > 1) {
      product.quantity--;
      product.currentPrince = product.quantity * product.price!;
    }
    for (var e in products) {
      totalPrice += e.quantity * e.price!;
    }

    update();
  }
}
