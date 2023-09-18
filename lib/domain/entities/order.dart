class Order {
  final dynamic id;
  final dynamic nama_toko;
  final dynamic alamat_toko;
  final dynamic tanggal;
  final dynamic status;
  final dynamic kembali;
  final dynamic terjual;
  final dynamic price;
  final dynamic sample;

  const Order({
    required this.id,
    required this.nama_toko,
    required this.alamat_toko,
    required this.tanggal,
    required this.status,
    required this.kembali,
    required this.terjual,
    required this.price,
    required this.sample,
  });

  factory Order.fromJson(Map<dynamic, dynamic> json) {
    return Order(
      id: json['id'],
      nama_toko: json['nama_toko'],
      alamat_toko: json['alamat_toko'],
      tanggal: json['tanggal'],
      status: json['status'],
      kembali: json['return'],
      terjual: json['terjual'],
      sample: json['sample'],
      price: json['total_harga'],
    );
  }
}