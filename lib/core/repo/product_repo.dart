import 'package:dartz/dartz.dart';
import 'package:supra_cart/core/helper_function/failure.dart';
import 'package:supra_cart/core/models/comments_model.dart';
import 'package:supra_cart/core/models/product_model.dart';

import '../models/product_rate_model.dart';

abstract class HomeProductRepo{
  Future<Either<Failure,List<ProductModel>>>getHomeProducts();
  Future<Either<Failure,List<ProductRateModel>>>getProductRate(
      {required String productId});
  Future<Either<Failure,void>>addOrUpdateUserRate(
      {required String productId, required int rate, required String userId,required bool isUpdate});
  Stream<Either<Failure,List<CommentModel>>> getProductComments({required String productId});
  Future<Either<Failure,void>> addComment({required String productId, required String comment, required String userId,required String userName});
  Future<Either<Failure,void>>addProductToFav({required String productId, required String userId,required bool isFav});
  Future<Either<Failure,void>>removeProductFromFav({required String productId, required String userId});

}