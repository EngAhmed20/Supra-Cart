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
