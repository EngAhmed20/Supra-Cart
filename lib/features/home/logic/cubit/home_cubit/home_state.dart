part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeCubitInit extends HomeState {}
class NavBarChanged extends HomeState {
  final int selectedIndex;

  NavBarChanged(this.selectedIndex);
}
class GetHomeProductsLoading extends HomeState {}
class GetHomeProductsSuccess extends HomeState {
  final List<ProductModel> products;

  GetHomeProductsSuccess(this.products);

}
class GetHomeProductsFailure extends HomeState {
  final String errorMessage;

  GetHomeProductsFailure(this.errorMessage);
}
class GetProductRateLoading extends HomeState {}
class GetProductRateSuccess extends HomeState {

}
class GetProductRateFailure extends HomeState {
  final String errorMessage;

  GetProductRateFailure(this.errorMessage);
}
class AddOrUpdateUserRateLoading extends HomeState {}
class AddOrUpdateUserRateSuccess extends HomeState {}
class AddOrUpdateUserRateFailure extends HomeState {
  final String errorMessage;

  AddOrUpdateUserRateFailure(this.errorMessage);
}
class AddCommentLoading extends HomeState {}
class AddCommentSuccess extends HomeState {}
class AddCommentFailure extends HomeState {
  final String errorMessage;

  AddCommentFailure(this.errorMessage);
}
class GetProductCommentsLoading extends HomeState {}
class GetProductCommentsSuccess extends HomeState {

}
class GetProductCommentsFailure extends HomeState {
  final String errorMessage;

  GetProductCommentsFailure(this.errorMessage);
}
class SearchProductsFailure extends HomeState {
  final String errorMessage;

  SearchProductsFailure(this.errorMessage);
}
class GetCategoryProductFailure extends HomeState {
  final String errorMessage;

  GetCategoryProductFailure(this.errorMessage);
}
class Closed extends HomeState{

}
class AutoValidateState extends HomeState {

}
class AddToFavoritesLoading extends HomeState {}
class AddToFavoritesSuccess extends HomeState {}
class AddToFavoritesFailure extends HomeState {
  final String errorMessage;

  AddToFavoritesFailure(this.errorMessage);
}
class RemoveFromFavoritesLoading extends HomeState {}
class RemoveFromFavoritesSuccess extends HomeState {}
class RemoveFromFavoritesFailure extends HomeState {
  final String errorMessage;

  RemoveFromFavoritesFailure(this.errorMessage);
}
class GetFavoriteProductsLoading extends HomeState {}
class GetFavoriteProductsSuccess extends HomeState {

}
class GetFavoriteProductsFailure extends HomeState {
  final String errorMessage;

  GetFavoriteProductsFailure(this.errorMessage);
}
class PurchaseProductLoading extends HomeState {}
class PurchaseProductSuccess extends HomeState {

}
class PurchaseProductFailure extends HomeState {
  final String errorMessage;

  PurchaseProductFailure(this.errorMessage);
}
class GetPurchaseHistoryLoading extends HomeState {}
class GetPurchaseHistorySuccess extends HomeState {}
class GetPurchaseHistoryFailure extends HomeState {
  final String errorMessage;

  GetPurchaseHistoryFailure(this.errorMessage);
}
class CancelPurchaseLoading extends HomeState {}
class CancelPurchaseSuccess extends HomeState {}
class CancelPurchaseFailure extends HomeState {
  final String errorMessage;

  CancelPurchaseFailure(this.errorMessage);
}
class ConfirmReceiptLoading extends HomeState {}
class ConfirmReceiptSuccess extends HomeState {}
class ConfirmReceiptFailure extends HomeState {
  final String errorMessage;

  ConfirmReceiptFailure(this.errorMessage);
}
class ArchivePurchaseLoading extends HomeState {}
class ArchivePurchaseSuccess extends HomeState {}
class ArchivePurchaseFailure extends HomeState {
  final String errorMessage;

  ArchivePurchaseFailure(this.errorMessage);
}
class AddUserInfoLoading extends HomeState {}
class AddUserInfoSuccess extends HomeState {}
class AddUserInfoFailure extends HomeState {
  final String errorMessage;

  AddUserInfoFailure(this.errorMessage);
}
class GetUserInfoLoading extends HomeState {}
class GetUserInfoSuccess extends HomeState {

}
class GetUserInfoFailure extends HomeState {
  final String errorMessage;

  GetUserInfoFailure(this.errorMessage);
}
class UpdateUserInfoLoading extends HomeState {}
class UpdateUserInfoSuccess extends HomeState {}
class UpdateUserInfoFailure extends HomeState {
  final String errorMessage;

  UpdateUserInfoFailure(this.errorMessage);
}