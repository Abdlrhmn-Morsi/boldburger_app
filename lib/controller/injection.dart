import 'package:boldburger/controller/price_controller.dart';
import 'auth_controller.dart';
import 'add_img_controller.dart';
import 'crud_product_controller.dart';
import 'dark_mode_controller.dart';
import 'get_product_controller.dart';
import 'search_controller.dart';
import 'package:get/get.dart';

class Injection {
  DarkModeController darkModeController = Get.put(DarkModeController());
  PriceController priceController = Get.put(PriceController());
  GetProductController productController = Get.put(GetProductController());
  CrudProductController controller = Get.put(CrudProductController());
  AuthController authController = Get.put(AuthController());
  SearchController searchController = Get.put(SearchController());
  AddImgController addImgController = Get.put(AddImgController());
}
