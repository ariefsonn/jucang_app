class Sales {
  final dynamic id;
  final dynamic name;
  final dynamic phone;
  final dynamic type;

  const Sales ({
    required this.id,
    required this.name,
    required this.phone,
    required this.type,
  });

  factory Sales.fromJson(Map<dynamic, dynamic> json) {
    return Sales(
      id: json['id'],
      name: json['name'],
      phone: json['no_tlp'],
      type: json['tipe'],
    );
  }
}
