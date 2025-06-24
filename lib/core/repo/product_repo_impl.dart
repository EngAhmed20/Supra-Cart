import 'package:dartz/dartz.dart';
import 'package:supra_cart/core/helper_function/base_api_services.dart';
import 'package:supra_cart/core/helper_function/failure.dart';
import 'package:supra_cart/core/models/product_model.dart';
import 'package:supra_cart/core/repo/product_repo.dart';
import 'package:supra_cart/core/utilis/constants.dart';

class HomeProductRepoImpl implements HomeProductRepo {
  BaseApiServices apiServices;
  HomeProductRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, List<ProductModel>>> getHomeProducts() async{
    final response=await apiServices.getData(path:homeProductsUrl);
   return response.fold((failure)
      =>Left( Failure(message: failure.message)), (successResponse){
      final data=successResponse as List;
      final products=data.map((e)=>ProductModel.fromJson(e as Map<String, dynamic>)).toList();
      return Right(products);

    });

  }

}