class Product {
  final int id;
  final dynamic name;
  final dynamic price;
  
  const Product({
    required this.id,
    required this.name,
    required this.price
  });
  
  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(id: json['id'], name: json['nama_produk'], price: json['harga']);
  }
}