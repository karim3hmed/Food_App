import 'package:foodapp/core/Network/api_service.dart';
import 'package:foodapp/features/Home/Data/product_model.dart';
import 'package:foodapp/features/product/data/product_deatail_model.dart';

class ProductRepo {
  ApiService apiService = ApiService();
  // get product
  Future<List<ProductModel>> getProduct() async {
    try {
      final response = await apiService.get("/products/");

      return (response["data"] as List)
          .map((e) => ProductModel.fromjson(e))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // topping
  Future<List<ProductDeatailModel>> gettopping() async {
    try {
      final response = await apiService.get("/toppings");
      return (response["data"] as List)
          .map((e) => ProductDeatailModel.fromjson(e))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // get side option
  Future<List<ProductDeatailModel>> getSideOption() async {
    try {
      final response = await apiService.get("/side-options");
      return (response["data"] as List)
          .map((e) => ProductDeatailModel.fromjson(e))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
