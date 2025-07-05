import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart/core/models/product_model.dart';
import 'package:supra_cart/core/repo/product_repo.dart';
import 'package:supra_cart/core/utilis/user_model.dart';

import '../../../../../core/models/comments_model.dart';
import '../../../../../core/models/product_rate_model.dart';
import '../../../../../core/utilis/constants.dart';
import '../../../ui/widgets/search_view.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo, this.client,this.sharedPreferences) : super(HomeCubitInit());
  final HomeProductRepo homeRepo;
  SupabaseClient client;
  late TextEditingController feedBackController;
  late TextEditingController searchController;
  late GlobalKey<FormState> feedbackFormKey;
  late GlobalKey<FormState>searchForm;
  late GlobalKey<FormState>storeSearchForm;


  AutovalidateMode autovalidateMode= AutovalidateMode.disabled;

   SharedPreferences sharedPreferences;
  int currentIndex = 0;
  init()async{
    feedBackController = TextEditingController();
    feedbackFormKey = GlobalKey<FormState>();
    searchForm = GlobalKey<FormState>();
    storeSearchForm = GlobalKey<FormState>();
    searchController = TextEditingController();
    await getUserDataFromPrefs();
    emit(HomeCubitInit());
  }
  Future<void> getUserDataFromPrefs() async {
    final prefs = await sharedPreferences.getString(userData);
    if (prefs != null) {
      final userData=jsonDecode(prefs);
      userSavedDataModel= UserModel.fromJson(userData);
      await sharedPreferences.setString(userId, userSavedDataModel.id!);
      return;
    }
    userSavedDataModel;

  }

  UserModel userSavedDataModel= UserModel(
    id: '0',
    name: 'userName',
    email: 'UserEmail',
  );
  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarChanged(currentIndex));
  }

  List <ProductModel> homeProducts = [];

  Future<void> getHomeProducts() async {
    homeProducts.clear();
    emit(GetHomeProductsLoading());
    final response = await homeRepo.getHomeProducts();
    response.fold(
          (failure) => emit(GetHomeProductsFailure(failure.message)),
          (successResponse) {
        for (var product in successResponse) {
          homeProducts.add(product);
        }

        emit(GetHomeProductsSuccess(successResponse));
      },
    );
    print(response.toString());
  }

  /// get product rate
  List <ProductRateModel> productRateList = [];
  int avgRate = 0;
  int userRate = 0;

  Future<void> getProductRate({required String productId}) async {
    emit(GetProductRateLoading());
    final response = await homeRepo.getProductRate(productId: productId);
    response.fold(
          (failure) => emit(GetProductRateFailure(failure.message)),
          (successResponse) {
        productRateList.clear();
        for (var rate in successResponse) {
          productRateList.add(rate);
        }
        _getAvgRate();
        _getUserRate();

        emit(GetProductRateSuccess());
      },
    );
  }

  void _getAvgRate() {
    avgRate = 0;
    for (var productRate in productRateList) {
      if (productRate.rate != null || productRate.rate != 0) {
        avgRate += productRate.rate!;
        avgRate = ((avgRate / productRateList.length)).toInt();
      }
    }
  }

  void _getUserRate() {
    List<ProductRateModel> userRates = productRateList.where((rate) =>
    rate.forUser == client.auth.currentUser!.id).toList();
    if (userRates.isNotEmpty) {
      userRate = userRates[0].rate!;
    }
    else {
      userRate = 0;
    }
  }

///////////update&rate
  bool _isUserRateExist({required String productId}) {
    for (var rate in productRateList) {
      if (rate.forProduct == productId &&
          rate.forUser == client.auth.currentUser!.id) {
        return true;
      }
    }
    return false;
  }

  Future<void> addOrUpdateUserRate(
      {required String productId, required int rate}) async {
    emit(AddOrUpdateUserRateLoading());
    bool userRateIsExist = _isUserRateExist(productId: productId);
    final response = await homeRepo.addOrUpdateUserRate(
        productId: productId,
        rate: rate,
        userId: client.auth.currentUser!.id,
        isUpdate: userRateIsExist
    );
    response.fold(
          (failure) => emit(AddOrUpdateUserRateFailure(failure.message)),
          (successResponse) {
        if (userRateIsExist) {
          log('user rate updated');
        } else {
          log('user rate added');
        }
        getProductRate(productId: productId);
        emit(AddOrUpdateUserRateSuccess());
      },
    );
  }

///////comments
  List <CommentModel> productComments = [];
  StreamSubscription? _streamSubscription;
  Future<void> getProductComments({required String productId}) async {
    productComments.clear();

    emit(GetProductCommentsLoading());
    _streamSubscription=homeRepo.getProductComments(productId:productId).listen((result){
      result.fold(
            (failure) => emit(GetProductCommentsFailure(failure.message)),
            (comments) {
          for (var comment in comments) {
            productComments.add(comment);
          }
          emit(GetProductCommentsSuccess());
        },
      );
    });


  }
  Future<void> addComment(
      {required String productId, required String comment,}) async {
    emit(AddCommentLoading());
    final response = await homeRepo.addComment(
        productId: productId,
        comment: comment,
        userId: client.auth.currentUser!.id,
        userName: userSavedDataModel.name??'userName',);
    response.fold(
          (failure) => emit(AddCommentFailure(failure.message)),
          (successResponse) {
        getProductComments(productId: productId);
        emit(AddCommentSuccess());
      },
    );
  }
  Future<void>sendCommentFun({required String productId})async{
    if(feedbackFormKey.currentState!.validate()){
      await addComment(productId: productId, comment: feedBackController.text);
      feedBackController.clear();
    }else{

    }
  }
  ///////////////////search
  List<ProductModel>productSearchList = [];
void search(String query) {
  productSearchList.clear();
  emit(GetHomeProductsLoading());
  for (var product in homeProducts) {
    if (product.name.toLowerCase().contains(query.toLowerCase())) {
      productSearchList.add(product);
    }
  }
  if (productSearchList.isEmpty) {
    emit(SearchProductsFailure('No products found'));
  } else {
    emit(GetHomeProductsSuccess(productSearchList));
  }
}
//searchButton
  void searchButton(context, {bool fromView = true}) {
    if(fromView){
      if (searchForm.currentState!.validate()) {
        search(searchController.text);
        Navigator.pushNamed(context, SearchView.routeName);
        autovalidateMode = AutovalidateMode.disabled;

      } else {
        autovalidateMode = AutovalidateMode.always;
        emit(AutoValidateState());

      }
    }else{
      if (storeSearchForm.currentState!.validate()) {
        search(searchController.text);
        Navigator.pushNamed(context, SearchView.routeName);
        autovalidateMode = AutovalidateMode.disabled;

      } else {
        autovalidateMode = AutovalidateMode.always;
        emit(AutoValidateState());

      }
    }
  }

///////////////category
  List<ProductModel> productCategoryList = [];
 String?categoryName;
  void filterByCategory({required String category}) {
    categoryName=category;
    productCategoryList.clear();
    emit(GetHomeProductsLoading());
    for (var product in homeProducts) {
      if (product.category.trim().toLowerCase() == category.toLowerCase()) {
        productCategoryList.add(product);
      }
    }
    if (productCategoryList.isEmpty) {
      emit(GetCategoryProductFailure('No products found'));
    } else {
      emit(GetHomeProductsSuccess(productCategoryList));
    }
  }

clear(){
  searchController.clear();
  categoryName=null;
  emit(Closed());

}

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    feedBackController.dispose();
    searchController.dispose();
    return super.close();
  }
}