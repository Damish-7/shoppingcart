// lib/app/models/product_model.dart

class ProductModel {
  final int    id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int    stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> j) => ProductModel(
    id:          j['id'] is int ? j['id'] : int.parse(j['id'].toString()),
    name:        j['name']        ?? '',
    description: j['description'] ?? '',
    price:       double.tryParse(j['price'].toString()) ?? 0.0,
    imageUrl:    j['image_url']   ?? 'https://picsum.photos/400',
    stock:       j['stock'] is int ? j['stock'] : int.parse(j['stock'].toString()),
  );
}