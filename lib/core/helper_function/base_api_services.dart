import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'failure.dart';

abstract class BaseApiServices{
  Future<Either<Failure, Response>> getData({required String path});
  Future<Either<Failure, Response>> postData({required String path, Map<String, dynamic>? data});
  Future<Either<Failure, Response>> patchData({required String path, Map<String, dynamic>? data});
  Future<Either<Failure, Response>> deleteData({required String path});

}