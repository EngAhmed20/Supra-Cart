import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/product_card.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';
import '../../features/home/ui/main_home_view.dart';
import '../../features/product_details/ui/product_details_view.dart';
import '../../features/profile/ui/widgets/delivery_info_view.dart';
import '../helper_function/dummy_product_list.dart';
import '../style/app_colors.dart';
import 'custom_snack_bar.dart';

class ProductList extends StatelessWidget {
  final String routeName = '/productList';
  const ProductList({super.key, this.shrinkWrap, this.physics, this.showFavProduct=false});
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final bool? showFavProduct;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        final productToDisplay =
            cubit.searchController.text.isNotEmpty
                ? cubit.productSearchList
                : cubit.categoryName != null
                ? cubit.productCategoryList
                : showFavProduct ==true
                ? cubit.favProducts
                : cubit.homeProducts;
        if (state is GetHomeProductsLoading) {
          return Skeletonizer(
            child: ListView.separated(
              shrinkWrap: shrinkWrap ?? true,
              physics: physics ?? NeverScrollableScrollPhysics(),
              itemBuilder:
                  (context, index) => ProductCard(
                    productModel: dummyProductList[index],
                    buyNowButton: () {},
                    favButton: () {},
                  ),
              separatorBuilder:
                  (context, index) =>
                      Container(width: 5.h, color: AppColors.kGreyColor),
              itemCount: dummyProductList.length,
            ),
          );
        } else if (state is GetHomeProductsFailure) {
          return Center(
            child: Text(state.errorMessage, style: textStyle.Bold16),
          );
        } else if (state is SearchProductsFailure ||
            state is GetCategoryProductFailure) {
          return Center(
            child: Text("No matching products found.", style: textStyle.Bold16),
          );
        } else if (state is GetFavoriteProductsFailure) {
          return Center(
            child: Text(
              "You haven't added any products to your favorites yet.",textAlign: TextAlign.center,
              style: textStyle.Bold16,
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: shrinkWrap ?? true,
          physics: physics ?? NeverScrollableScrollPhysics(),
          itemBuilder:
              (context, index) => ProductCard(
                productModel: productToDisplay[index],
                buyNowButton: () {
                  if(cubit.userInfoModel==null){
                    customSnackBar(
                      context: context,
                      msg: 'Please add your delivery information first.',
                      isError: true,
                    );
                    Navigator.pushNamed(context, DeliveryInfoView.routeName);
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentView(
                          onPaymentSuccess: () async{
                            await cubit.purchaseProduct(productId: productToDisplay[index].id);
                            cubit.changeIndex(0);

                          },
                          onPaymentError: () {
                            log("payment error");
                            // Handle payment failure
                          },
                          price: productToDisplay[index].price.toDouble(),
                        ),
                      ),
                    );

                  }
                },
                isFav: cubit.checkIsFav(productId: productToDisplay[index].id),
                favButton: () {
                  bool isFav = cubit.checkIsFav(
                    productId: productToDisplay[index].id,
                  );

                  isFav
                      ? cubit.removeProductFromFav(
                        productId: productToDisplay[index].id,
                      )
                      : cubit.addProductToFav(
                        productId: productToDisplay[index].id,
                      );
                },
                onTap: () async {
                  await cubit.getProductRate(
                    productId: productToDisplay[index].id,
                  );
                  await cubit.getProductComments(
                    productId: cubit.homeProducts[index].id,
                  );
                  Navigator.pushNamed(
                    context,
                    ProductDetailsView.routeName,
                    arguments: productToDisplay[index],
                  );
                },
              ),
          separatorBuilder:
              (context, index) =>
                  Container(height: 10.h, color:Colors.transparent),
          itemCount: productToDisplay.length,
        );
      },
      listener: (context, state) {
        if (state is AddToFavoritesSuccess) {
          customSnackBar(
            context: context,
            msg: 'Awesome! The item is now in your favorites',
            isError: false,
          );
        } else if (state is AddToFavoritesFailure) {
          customSnackBar(
            context: context,
            msg: 'An error occurred.Please try again later.',
            isError: true,
          );
        } else if (state is RemoveFromFavoritesSuccess) {
          customSnackBar(
            context: context,
            msg: 'Item has been removed from your favorites',
            isError: false,
          );
        }else if(state is PurchaseProductSuccess) {

          customSnackBar(
            context: context,
            msg: 'Product purchased successfully',
            isError: false,
          );
          //          Navigator.pushReplacementNamed(context, MainHomeView.routeName);
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainHomeView.routeName,
                (route) => false,
          );

        }else if (state is PurchaseProductFailure) {
          customSnackBar(
            context: context,
            msg: 'An error occurred.Please try again later.',
            isError: true,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainHomeView.routeName,
                (route) => false,
          );

        }

      },
    );
  }
}
