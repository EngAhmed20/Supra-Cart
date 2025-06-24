import 'package:dartz/dartz.dart';
import 'package:supra_cart/core/helper_function/failure.dart';
import 'package:supra_cart/core/models/product_model.dart';

abstract class HomeProductRepo{
  Future<Either<Failure,List<ProductModel>>>getHomeProducts();
}