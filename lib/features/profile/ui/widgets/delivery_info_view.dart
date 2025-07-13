import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/custom_app_bar.dart';
import 'package:supra_cart/core/widgets/loadibg_ink_drop.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';

import 'delivery_info_form.dart';



class DeliveryInfoView extends StatelessWidget {
   const DeliveryInfoView({super.key});
  static const String routeName = '/deliveryInfo';

  @override
  Widget build(BuildContext context) {

return BlocConsumer<HomeCubit,HomeState>(
  builder: (context,state){
    var cubit=context.read<HomeCubit>();

    return Scaffold(
      appBar: customAppBar(context, title: 'Delivery Info'),
      floatingActionButton: FloatingActionButton(onPressed: (){

        showModalBottomSheet(context: context,
            enableDrag: true,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            builder: (context){
              return Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 16.h,
                ),
                child: InfoForm(cubit: cubit,),
              );
            });

      },
        backgroundColor: AppColors.kPrimaryColor,
        child: Icon(Icons.edit_location_outlined,size: 28.h,
          color: AppColors.kWhiteColor,),),
      body: Builder(builder: (_){
        if(state is GetUserInfoLoading|| state is UpdateUserInfoLoading || state is AddUserInfoLoading)
          {
            return Loading_body(context);
          }if(state is GetUserInfoFailure || cubit.userInfoModel == null) {
          return Center(
            child: Text(
              'No delivery information available yet.'
                  '\nPlease add your details to proceed.',
              textAlign: TextAlign.center,
              style: textStyle.Bold16.copyWith(color: AppColors.kPrimaryColor),
            ),
          );
        }

        return Card(
          color: AppColors.kGreyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                InfoRow(title: 'Phone:', value: cubit.userInfoModel?.mobilePhone ?? ''),
                InfoRow(title: 'Governorate:', value: cubit.userInfoModel?.governorate ?? ''),
                InfoRow(title: 'City:', value: cubit.userInfoModel?.city ?? ''),
                if (cubit.userInfoModel?.additionalInfo?.isNotEmpty ?? false)
                  InfoRow(title: 'Additional:', value: cubit.userInfoModel!.additionalInfo!),
              ],
            ),
          ),
        );

      })
    );
  },
  listener: (context,state){

  },
);
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyle.Bold16,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: textStyle.regular16,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
