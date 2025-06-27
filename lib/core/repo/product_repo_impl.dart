import 'package:dartz/dartz.dart';
import 'package:supra_cart/core/helper_function/base_api_services.dart';
import 'package:supra_cart/core/helper_function/failure.dart';
import 'package:supra_cart/core/models/product_model.dart';
import 'package:supra_cart/core/models/product_rate_model.dart';
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

  @override
  Future<Either<Failure, List<ProductRateModel>>> getProductRate({required String productId}) async{
    final response=await apiServices.getData(path: productRateUrl+productId);
    return response.fold((failure) => Left(Failure(message: failure.message)), (successResponse) {
      final data = successResponse as List;
      print(data);
      final products = data.map((e) => ProductRateModel.fromJson(e as Map<String, dynamic>)).toList();
      return Right(products);
    });
  }

  @override
  Future<Either<Failure, void>> addOrUpdateUserRate({required String productId, required int rate, required String userId, required bool
  isUpdate}) async{
    if(isUpdate){
      final response=await apiServices.patchData(path:'${baseUrl}rates_table?select=*&for_user=eq.$userId&for_product=eq.$productId', data: {
        "rate": rate,
      });
      return response.fold((failure) => Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    }else{
      final response=await apiServices.postData(path: productRateAddUrl, data: {
        "for_user": userId,
        "for_product": productId,
        "rate": rate,
      });
      return response.fold((failure) => Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });

    }

  }

}