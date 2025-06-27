class ProductRateModel {
  final int? id;
  final DateTime createdAt;
  final int? rate;
  final String? forUser;
  final String? forProduct;

  ProductRateModel({
    this.id,
    required this.createdAt,
    required this.rate,
    required this.forUser,
    required this.forProduct,
  });

  factory ProductRateModel.fromJson(Map<String, dynamic> json) {
    return ProductRateModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      rate: json['rate']?? 0,
      forUser: json['for_user']?? '',
      forProduct: json['for_product']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'rate': rate,
      'for_user': forUser,
      'for_product': forProduct,
    };
  }
}
