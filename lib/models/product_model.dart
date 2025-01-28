class Product {
  final int idProduct;
  final int idHeadquarters;
  final String rfid;
  final String stateProduct;
  final String description;
  final String locationRaw;
  final int line;
  final int palm;

  Product({
    required this.idProduct,
    required this.idHeadquarters,
    required this.stateProduct,
    required this.rfid,
    required this.description,
    required this.locationRaw,
    required this.line,
    required this.palm,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idProduct: json['id_product'],
      idHeadquarters: json['id_headquarter'],
      stateProduct: json['state_product'],
      rfid: json['rfid'],
      description: json['description_product'],
      locationRaw: json['location_raw'],
      line: json['line'],
      palm: json['palm'],
    );
  }
}