import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart/core/models/product_model.dart';
import 'package:supra_cart/core/repo/product_repo.dart';

import '../../../../../core/models/product_rate_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo,this.client) : super(HomeCubitInit());
  final HomeProductRepo homeRepo;
  SupabaseClient client;
  int currentIndex=0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarChanged(currentIndex));
  }
  List <ProductModel> homeProducts = [];
  Future<void>getHomeProducts()async{
    homeProducts.clear();
    emit(GetHomeProductsLoading());
    final response = await homeRepo.getHomeProducts();
    response.fold(
      (failure) => emit(GetHomeProductsFailure(failure.message)),
      (successResponse) {
        for(var product in successResponse){
          homeProducts.add(product);
        }
        emit(GetHomeProductsSuccess(successResponse));},
    );
    print(response.toString());


  }
  /// get product rate
  List <ProductRateModel> productRateList = [];
  int avgRate=0;
  int userRate=0;
Future<void>getProductRate({required String productId})async{
  emit(GetProductRateLoading());
  final response = await homeRepo.getProductRate(productId: productId);
  response.fold(
    (failure) => emit(GetProductRateFailure(failure.message)),
    (successResponse) {
      productRateList.clear();
      for(var rate in successResponse){
        productRateList.add(rate);
      }
      _getAvgRate();
     _getUserRate();

      emit(GetProductRateSuccess());
    },
  );
}
void _getAvgRate(){
  avgRate = 0;
  for(var productRate in productRateList){
    if(productRate.rate!=null|| productRate.rate!=0)
    {
      avgRate += productRate.rate!;
      avgRate=((avgRate/productRateList.length)).toInt();

    }

  }

}
void _getUserRate(){
  List<ProductRateModel> userRates=productRateList.where((rate)=>rate.forUser==client.auth.currentUser!.id).toList();
  if(userRates.isNotEmpty) {
    userRate = userRates[0].rate!;
  }
  else {
    userRate = 0;
  }
}
///////////update&rate
bool _isUserRateExist({required String productId}) {
  for(var rate in productRateList) {
    if(rate.forProduct==productId && rate.forUser==client.auth.currentUser!.id) {
      return true;
    }

  }
return false;

}
Future<void>addOrUpdateUserRate({required String productId,required int rate})async{
  emit(AddOrUpdateUserRateLoading());
  bool userRateIsExist= _isUserRateExist(productId: productId);
  final response=await homeRepo.addOrUpdateUserRate(
    productId: productId,
    rate: rate,
    userId: client.auth.currentUser!.id,
    isUpdate: userRateIsExist
  );
  response.fold(
    (failure) => emit(AddOrUpdateUserRateFailure(failure.message)),
    (successResponse) {
      if(userRateIsExist){
        log('user rate updated');
      }else{
        log('user rate added');
      }
      getProductRate(productId: productId);
      emit(AddOrUpdateUserRateSuccess());
    },
  );

}
}
