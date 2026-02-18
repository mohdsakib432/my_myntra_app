class ProductModel {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price; // ✅ MUST be double
  final String? images;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: _parsePrice(json['price']), // ✅ FIX
      images: json['images'],
    );
  }

  static double? _parsePrice(dynamic value) {
    if (value == null) return null;

    if (value is num) {
      return value.toDouble();
    }

    if (value is String) {
      return double.tryParse(value);
    }

    return null;
  }
}
