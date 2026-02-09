// send to backend
class CartModel {
  final int product_id;
  final int quantity;
  final double spicy;
  final List<int> toppings;
  final List<int> options;

  CartModel({
    required this.product_id,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.options,
  });

  Map<String, dynamic> toJson() => {
    "product_id": product_id,
    "quantity": quantity,
    "spicy": spicy,
    "toppings": toppings,
    "side_options": options,
  };
}

class CartRequestModel {
  final List<CartModel> items;

  CartRequestModel({required this.items});

  Map<String, dynamic> toJson() => {
    "items": items.map((e) => e.toJson()).toList(),
  };
}

// get from backend

class GetCartResponse {
  final int code;
  final String message;
  CartData cartData;

  GetCartResponse({
    required this.code,
    required this.message,
    required this.cartData,
  });

  factory GetCartResponse.fromjson(Map<String, dynamic> json) {
    return GetCartResponse(
      code: json["code"] ?? 200,
      message: json["message"],
      cartData: CartData.fromjson(json["data"]),
    );
  }
}

class CartData {
  final int id;
  final String TotalPrice;
  List<CartItem> items;

  CartData({required this.id, required this.TotalPrice, required this.items});

  factory CartData.fromjson(Map<String, dynamic> json) {
    return CartData(
      id: json["id"],
      TotalPrice: json["total_price"],
      items: (json["items"] as List).map((e) => CartItem.fromjson(e)).toList(),
    );
  }
}

class CartItem {
  final int item_id;
  final int product_id;
  final String name;
  final String image;
  final int quantity;
  final double spicy;
  final String price;

  CartItem({
    required this.item_id,
    required this.product_id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.spicy,
    required this.price,
  });

  factory CartItem.fromjson(Map<String, dynamic> json) {
    return CartItem(
      item_id: json["item_id"],
      product_id: json["product_id"],
      name: json["name"],
      image: json["image"],
      quantity: json["quantity"],
      spicy: double.tryParse(json["spicy"].toString()) ?? 0.0,
      price: json["price"].toString(),
    );
  }
}
