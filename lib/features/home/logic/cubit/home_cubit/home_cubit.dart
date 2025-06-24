import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:supra_cart/core/helper_function/base_api_services.dart';
import 'package:supra_cart/core/models/product_model.dart';
import 'package:supra_cart/core/repo/product_repo.dart';

import '../../../../../core/utilis/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeCubitInit());
  final HomeProductRepo homeRepo;
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
}
