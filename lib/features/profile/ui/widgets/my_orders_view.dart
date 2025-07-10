import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/widgets/custom_app_bar.dart';
import 'package:supra_cart/core/widgets/custom_snack_bar.dart';
import 'package:supra_cart/core/widgets/loadibg_ink_drop.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';
import 'package:supra_cart/features/profile/ui/widgets/no_orders_yet.dart';
import 'package:supra_cart/features/profile/ui/widgets/orders_card.dart';

import '../../../product_details/ui/product_details_view.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});
  static const String routeName = '/myOrders';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return Scaffold(
          appBar: customAppBar(context, title: 'My Orders'),
          backgroundColor: cubit.purchaseProducts.isNotEmpty?Colors.orange:Colors.white,

          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Builder(
              builder: (_) {
                if (state is GetHomeProductsLoading) {
                  return Loading_body(context);
                } else if (state is GetPurchaseHistoryFailure) {
                  return NoOrdersYet();
                }

                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder:
                      (context,index) => OrderCard(
                        productModel: cubit.purchaseProducts[index].product,
                        cancelOrder: () {
                          cubit.cancelPurchase(purchaseId: cubit.purchaseProducts[index].purchaseModel.id!);
                        },confirmReceipt: () {
                          cubit.confirmReceipt(purchaseId: cubit.purchaseProducts[index].purchaseModel.id!);
                      }, archiveOrder: () {
                          cubit.archivePurchase(purchaseId: cubit.purchaseProducts[index].purchaseModel.id!);
                        },
                        onTap: () async {
                          await cubit.getProductRate(
                            productId: cubit.purchaseProducts[index].product.id,
                          );
                          await cubit.getProductComments(
                            productId: cubit.purchaseProducts[index].product.id,
                          );
                          Navigator.pushNamed(
                            context,
                            ProductDetailsView.routeName,
                            arguments: cubit.purchaseProducts[index].product,
                          );
                        },
                         orderStatus: cubit.purchaseProducts[index].purchaseModel.orderStatus,
                      ),
                  separatorBuilder: (context, state) {
                    return Container(height: 5.h);
                  },
                  itemCount: cubit.purchaseProducts.length,
                );
              },
            ),
          ),
        );
      },
      listener: (BuildContext context, HomeState state) {
        if(state is CancelPurchaseSuccess){
          customSnackBar(context: context, msg: 'Order Cancelled Successfully', isError: false);
        }
        if(state is ConfirmReceiptSuccess){
          customSnackBar(context: context, msg: 'Order Confirmed Successfully', isError: false);
        }
        if(state is ArchivePurchaseSuccess){
          customSnackBar(context: context, msg: 'Order Archived Successfully', isError: false);
        }

      },
    );
  }
}
