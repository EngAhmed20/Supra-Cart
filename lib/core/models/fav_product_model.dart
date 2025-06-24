class FavoriteProductModel {
  final String id;
  final String forUser;
  final String forProduct;
  final bool isFavorite;
  final DateTime createdAt;

  FavoriteProductModel({
    required this.id,
    required this.forUser,
    required this.forProduct,
    required this.isFavorite,
    required this.createdAt,
  });

  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductModel(
      id: json['id'] ?? '',
      forUser: json['for_user'] ?? '',
      forProduct: json['for_product'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'for_user': forUser,
      'for_product': forProduct,
      'is_favorite': isFavorite,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
