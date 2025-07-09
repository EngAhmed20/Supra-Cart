import 'package:supra_cart/core/models/purchase_model.dart';

import '../../../core/models/product_model.dart';

class PurchaseProductModel {
  final ProductModel product;
  final PurchaseModel purchaseModel;


  PurchaseProductModel({required this.product, required this.purchaseModel});
}
