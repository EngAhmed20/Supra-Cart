import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart/core/models/product_model.dart';
import 'package:supra_cart/core/repo/product_repo.dart';
import 'package:supra_cart/core/secret_data.dart';
import 'package:supra_cart/core/utilis/user_model.dart';
import 'package:supra_cart/features/profile/logic/purchase_product_model.dart';

import '../../../../../core/models/comments_model.dart';
import '../../../../../core/models/product_rate_model.dart';
import '../../../../../core/models/purchase_model.dart';
import '../../../../../core/utilis/constants.dart';
import '../../../ui/widgets/search_view.dart';

part 'home_state.dart';
enum OrderStatus {pending,processing, onTheWay,delivered}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo, this.client,this.sharedPreferences) : super(HomeCubitInit());
  final HomeProductRepo homeRepo;
  SupabaseClient client;
  late TextEditingController feedBackController;
  late TextEditingController searchController;
  late GlobalKey<FormState> feedbackFormKey;
  //late GlobalKey<FormState>searchForm;
 // late GlobalKey<FormState>storeSearchForm;


  AutovalidateMode autovalidateMode= AutovalidateMode.disabled;

   SharedPreferences sharedPreferences;
  int currentIndex = 0;
  init()async{
    feedBackController = TextEditingController();
    feedbackFormKey = GlobalKey<FormState>();
    //searchForm = GlobalKey<FormState>();
    //storeSearchForm = GlobalKey<FormState>();
    searchController = TextEditingController();
    await getUserDataFromPrefs();
    initPaymobIntegration();
    emit(HomeCubitInit());
  }
  UserModel userSavedDataModel= UserModel(
    id: '0',
    name: 'userName',
    email: 'UserEmail',
  );
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


  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarChanged(currentIndex));
    if(index==2){
      getFavProducts();
    }
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
  void searchButton(context,{required GlobalKey<FormState> searchForm}) {

      if (searchForm.currentState!.validate()) {
        search(searchController.text);
        Navigator.pushNamed(context, SearchView.routeName);
        autovalidateMode = AutovalidateMode.disabled;

      } else {
        autovalidateMode = AutovalidateMode.always;
        emit(AutoValidateState());

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
//////////////////////////////////////////////////////////////
  /// add to fav
  Future<void>addProductToFav({required String productId,})async{
    emit(AddToFavoritesLoading());
    final response =await homeRepo.addProductToFav(productId: productId, userId: userSavedDataModel.id!, isFav:true);
    response.fold(
          (failure) => emit(AddToFavoritesFailure(failure.message)),
          (successResponse) async{
        log('product added to fav');
        await getHomeProducts();
        emit(AddToFavoritesSuccess());
      },
    );
  }
  bool checkIsFav({required String productId}) {
    for (var product in homeProducts) {
      if (product.favoriteProducts.isNotEmpty) {
        for (var fav in product.favoriteProducts) {
          if (fav.forUser == userSavedDataModel.id! && fav.forProduct==productId&& fav.isFavorite == true) {
            return true;
          }
        }
      }
    }
    return false;
  }
  /// get favProducts
  List<ProductModel> favProducts = [];
  void getFavProducts() {
    favProducts.clear();
    emit(GetHomeProductsLoading());
    for (var product in homeProducts) {
      if (product.favoriteProducts.isNotEmpty) {
        for (var fav in product.favoriteProducts) {
          if (fav.forUser == userSavedDataModel.id! && fav.isFavorite ==true) {
            favProducts.add(product);
          }
        }
      }
    }
    if (favProducts.isEmpty) {
      emit(GetFavoriteProductsFailure('No favorite products found'));
    } else {
      emit(GetFavoriteProductsSuccess());
    }
  }

  ///remove from fav
  Future<void>removeProductFromFav({required String productId})async{
    emit(RemoveFromFavoritesLoading());
    final response =await homeRepo.removeProductFromFav(productId: productId, userId: userSavedDataModel.id!);
    response.fold(
          (failure) => emit(RemoveFromFavoritesFailure(failure.message)),
          (successResponse) async{
        log('product removed from fav');
        await getHomeProducts();

        emit(RemoveFromFavoritesSuccess());
        if(currentIndex==2){
          getFavProducts();
        }
      },
    );
  }
  ///init paymob integration
  void initPaymobIntegration()  {
    PaymentData.initialize(
      apiKey: SecretData.paymobApiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: SecretData.iframeId, // Required: Found under Developers -> iframes
      integrationCardId: SecretData.paymobIntegrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId: SecretData.paymobIntegrationWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID

      // Optional User Data
      userData:UserData(
        email: userSavedDataModel.email??'NA', // Optional: Defaults to 'NA'
        name: userSavedDataModel.name??'Na',
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: Colors.blue, // Default: Colors.blue
        scaffoldColor: Colors.white, // Default: Colors.white
        appBarBackgroundColor: Colors.blue, // Default: Colors.blue
        appBarForegroundColor: Colors.white, // Default: Colors.white
        textStyle: TextStyle(), // Default: TextStyle()
        buttonStyle: ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
        circleProgressColor: Colors.blue, // Default: Colors.blue
        unselectedColor: Colors.grey, // Default: Colors.grey
      ),
    );
  }
  /////////// purchase
  /// add purchase to dataBase
  Future<void> purchaseProduct({required String productId}) async {
    emit(PurchaseProductLoading());
    final purchaseModel = PurchaseModel(
      forUser: userSavedDataModel.id!,
      forProduct: productId,
      isBought: true,
      orderStatus: 'Pending',
    );
    final response = await homeRepo.purchaseProduct(purchaseModel:purchaseModel);
    response.fold(
          (failure) => emit(PurchaseProductFailure(failure.message)),
          (successResponse) {
        log('product purchased successfully');
        emit(PurchaseProductSuccess());
      },
    );
  }
  /// get purchase product
  List<PurchaseProductModel> purchaseProducts = [];
  Future<void>getPurchaseProducts()async{
   purchaseProducts.clear();
   await getHomeProducts();
   emit(GetHomeProductsLoading());
   for(var product in homeProducts){
     if(product.purchaseTable.isNotEmpty){
       for(var purchase in product.purchaseTable){
          if(purchase.forUser==userSavedDataModel.id! && purchase.isBought==true&&purchase.orderStatus!='Archived'){
            purchaseProducts.add(
              PurchaseProductModel(
                product: product,
                purchaseModel: purchase,
              ),
            );
          //  productStatusList.add(purchase.orderStatus);
            log('purchase product added');
          }
       }
     }
   }
   if(purchaseProducts.isEmpty){
     emit(GetPurchaseHistoryFailure('No purchase history found'));
   }else{
      emit(GetPurchaseHistorySuccess());
   }

  }
  /// cancel purchase
  Future<void>cancelPurchase({required String purchaseId})async{
    emit(CancelPurchaseLoading());
    final response = await homeRepo.cancelPurchase(purchaseId: purchaseId);
    response.fold(
          (failure) => emit(CancelPurchaseFailure(failure.message)),
          (successResponse) {
        log('purchase cancelled successfully');
        getPurchaseProducts();
        emit(CancelPurchaseSuccess());
      },
    );
  }
  /// confirm receipt
  Future<void>confirmReceipt({required String purchaseId})async{
    emit(ConfirmReceiptLoading());
    final response = await homeRepo.confirmReceipt(purchaseId: purchaseId);
    response.fold(
          (failure) => emit(ConfirmReceiptFailure(failure.message)),
          (successResponse) {
        getPurchaseProducts();
        emit(ConfirmReceiptSuccess());
      },
    );
  }
  /// archive purchase
  Future<void>archivePurchase({required String purchaseId})async{
    emit(ArchivePurchaseLoading());
    final response = await homeRepo.archivePurchase(purchaseId: purchaseId);
    response.fold(
          (failure) => emit(ArchivePurchaseFailure(failure.message)),
          (successResponse) {
        getPurchaseProducts();
        emit(ArchivePurchaseSuccess());
      },
    );
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