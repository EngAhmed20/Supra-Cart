class PurchaseModel {
  final String? id;
  final String forUser;
  final String forProduct;
  final bool isBought;
  final DateTime? createdAt;
  final String orderStatus;

  PurchaseModel( {
     this.id,
    required this.forUser,
    required this.forProduct,
    required this.isBought,
     this.createdAt,
    required this.orderStatus,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: json['id'] ?? '0',
      forUser: json['for_user'] ?? '',
      forProduct: json['for_product'] ?? '',
      isBought: json['is_bought'] ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      orderStatus:json['order_status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'for_user': forUser,
      'for_product': forProduct,
      'is_bought': isBought,
      'order_status': orderStatus,
     // 'created_at': createdAt.toIso8601String(),
    };
  }
}
