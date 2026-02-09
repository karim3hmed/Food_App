class ProductModel {
  final int id;
  final String name;
  final String image;
  final String rate;
  final String price;
  final String desc;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.desc,
    required this.rate,
  });

  factory ProductModel.fromjson(Map<String, dynamic> data) {
    return ProductModel(
      id: data["id"],
      image: data["image"],
      name: data["name"],
      price: data["price"],
      rate: data["rating"],
      desc: data["description"],
    );
  }
}
