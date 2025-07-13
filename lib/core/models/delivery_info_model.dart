class DeliveryInfoModel {
  final String? id;
  final DateTime? createdAt;
  final String forUser;
  final String mobilePhone;
  final String governorate;
  final String city;
  final String? additionalInfo;

  DeliveryInfoModel({
    this.id,
    this.createdAt,
    required this.forUser,
    required this.mobilePhone,
    required this.governorate,
    required this.city,
    this.additionalInfo,
  });

  factory DeliveryInfoModel.fromJson(Map<String, dynamic> json) {
    return DeliveryInfoModel(
      id: json['id'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      forUser: json['for_user'] ?? '',
      mobilePhone: json['mobile_phone'] ?? '',
      governorate: json['governorate'] ?? '',
      city: json['city'] ?? '',
      additionalInfo: json['additional_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'for_user': forUser,
      'mobile_phone': mobilePhone,
      'governorate': governorate,
      'city': city,
      'additional_info': additionalInfo,

    };
  }
}
