import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supra_cart/core/helper_function/base_api_services.dart';

import 'failure.dart';

class ApiServices extends BaseApiServices{

  final Dio dio;

  ApiServices({required this.dio});
  Future<Either<Failure, dynamic>> getData({required String path})async{
    try {
      Response response = await dio.get(path);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(Failure(message: 'Failed to get data: ${e.message}'));
    }
  }
  Future<Either<Failure, dynamic>>postData({required String path, Map<String, dynamic>? data})async{
    try {
      Response response = await dio.post(path, data: data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure(message: 'Failed to post data: ${e.message}'));
    }
  }
  Future<Either<Failure, dynamic>>patchData({required String path, Map<String, dynamic>? data})async{
    try {
      Response response = await dio.patch(path, data: data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure(message: 'Failed to patch data: ${e.message}'));
    }
  }
  Future<Either<Failure, dynamic>>deleteData({required String path})async{
    try {
      Response response = await dio.delete(path);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure(message: 'Failed to delete data: ${e.message}'));
    }
  }

}