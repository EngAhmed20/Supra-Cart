import 'package:dartz/dartz.dart';
import 'package:supra_cart/core/helper_function/failure.dart';
import 'package:supra_cart/core/models/delivery_info_model.dart';
import 'package:supra_cart/core/repo/user_info_repo.dart';
import 'package:supra_cart/core/utilis/constants.dart';
import '../helper_function/base_api_services.dart';
class UserInfoRepoImp implements UserInfoRepo{
  BaseApiServices apiServices;
  UserInfoRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, void>> addUserInfo({required String userId, required String phone, required String governorate, required String city, String? additionalInfo}) async{
    try{
      final response=await apiServices.postData(path: deliveryInfoTable, data: {
        'for_user': userId,
        'mobile_phone': phone,
        'governorate': governorate,
        'city': city,
        'additional_info': additionalInfo ?? '',
      });
     return  response.fold((failure){
        return Left(Failure(message: 'Failed to add user info: ${failure.message}'));

      },((success){
        return Right(null);
      }) );
      
    }catch(e){
      return Left(Failure(message: 'Failed to add user info: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DeliveryInfoModel>> getUserInfo({required String userId}) async{
    try{
      final response=await apiServices.getData(path: '$deliveryInfoTable?for_user=eq.$userId');
      return response.fold((failure){
        return Left(Failure(message: 'failed to get user info: ${failure.message}'));
      }, (data){
        if(data is List && data.isNotEmpty){
          final deliveryInfo = DeliveryInfoModel.fromJson(data.first);
          return Right(deliveryInfo);
        } else {
          return Left(Failure(message: 'No user info found'));
        }

      });

    }catch(e){
      return Left(Failure(message: 'Failed to get user info: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserInfo({required String userId, String? phone, String? governorate, String? city, String? additionalInfo}) async{
   try{
      final response=await apiServices.patchData(path:'$deliveryInfoTable?select=*&for_user=eq.$userId', data: {
        'mobile_phone': phone,
        'governorate': governorate,
        'city': city,
        'additional_info': additionalInfo ?? '',
      });
      return response.fold((failure){
        return Left(Failure(message: 'Failed to update user info: ${failure.message}'));
      }, (data){
        return Right(null);
      });

   }catch(e){
     return Left(Failure(message: 'Failed to update user info: ${e.toString()}'));

   }
  }

  
}