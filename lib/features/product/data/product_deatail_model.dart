class ProductDeatailModel {
  int id;
  String name;
  String image;

  ProductDeatailModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory ProductDeatailModel.fromjson(Map<String, dynamic> data) {
    return ProductDeatailModel(
      id: data["id"],
      image: data["image"],
      name: data["name"],
    );
  }
}
