import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'failure.dart';

abstract class BaseApiServices{
  Future<Either<Failure, dynamic>> getData({required String path});
  Future<Either<Failure, dynamic>> postData({required String path, Map<String, dynamic>? data});
  Future<Either<Failure, dynamic>> patchData({required String path, Map<String, dynamic>? data});
  Future<Either<Failure, dynamic>> deleteData({required String path});

}