import 'package:dartz/dartz.dart';
import 'package:supra_cart/core/helper_function/failure.dart';
import 'package:supra_cart/core/models/delivery_info_model.dart';

abstract class UserInfoRepo {
  Future<Either<Failure, void>> addUserInfo({
    required String userId,
    required String phone,
    required String governorate,
    required String city,
    String? additionalInfo,
  });
  Future<Either<Failure,DeliveryInfoModel>> getUserInfo({
    required String userId,
  });
  Future<Either<Failure, void>> updateUserInfo({
    required String userId,
     String? phone,
     String? governorate,
    String?  city,
    String? additionalInfo,
  });
}
