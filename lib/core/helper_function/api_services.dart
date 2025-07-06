import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart/core/helper_function/base_api_services.dart';

import 'failure.dart';

class ApiServices extends BaseApiServices{

  final Dio dio;
  Supabase supabase= Supabase.instance;

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

  @override
  Stream<Either<Failure, dynamic>> getStreamData({
    required String path,
    String? orderBy,
    bool descending = false,
    required String productId
  }) async* {
    try {
      final query = supabase.client
          .from(path)
          .stream(primaryKey: ['id']).eq('for_product',productId);

      final orderedQuery = orderBy != null
          ? query.order(orderBy, ascending: !descending)
          : query;
      await for(var event in orderedQuery) {
        if (event.isNotEmpty) {
          yield Right(event);
        } else {
          yield Left(Failure(message: 'No data found'));
        }
      }

    /*  yield* orderedQuery.map<Either<Failure, dynamic>>((event) {
        if (event.isNotEmpty) {
          return Right(event);
        } else {
          return Left(Failure(message: 'No data found'));
        }
      }).handleError((error) {

      });*/
    } catch (e) {
      log(e.toString());
      yield Left(Failure(message: 'Exception: ${e.toString()}'));
    }
  }



}