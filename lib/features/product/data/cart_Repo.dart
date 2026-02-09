import 'package:foodapp/core/Network/api_error.dart';
import 'package:foodapp/core/Network/api_service.dart';
import 'package:foodapp/features/product/data/cart_model.dart';

class CartRepo {
  ApiService apiService = ApiService();
  // add to cart
  Future<String> addtocart(CartRequestModel cartdata) async {
    final response = await apiService.post("/cart/add", cartdata.toJson());

    // SUCCESS
    return response['message'];
  }

  // get to cart
  Future<GetCartResponse?> GetCartData() async {
    try {
      final response = await apiService.get("/cart"); // مهم الـ slash
      print("CartRepo GET /cart response: $response"); // للطباعة
      if (response == null) {
        throw ApiError(message: "No data returned from server");
      }

      // حاول parse الـ JSON
      return GetCartResponse.fromjson(response);
    } catch (e, st) {
      print("CartRepo error: $e");
      print(st);
      throw ApiError(message: "Failed to load cart: ${e.toString()}");
    }
  }

  Future<void> RemoveCartItem(int id) async {
    try {
      final response = await apiService.delete("/cart/remove/$id", {});

      // إذا كان الكود 200 يبقى ناجح
      if (response["code"] == 200) {
        // هنا ممكن نتحقق لو عايز من data
        return; // العملية نجحت
      } else {
        // أي كود غير 200 يبقى خطأ
        throw ApiError(message: response["message"] ?? "Failed to remove item");
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
