import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form.dart';
import 'comments_widget.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key, required this.cubit, required this.productId});
  final HomeCubit cubit;
  final String
  productId; // Example product ID, replace with actual ID as needed

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.feedbackFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: 'Type your feedback here',
            maxLines: 2,
            controller: cubit.feedBackController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your feedback';
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {
                cubit.sendCommentFun(productId: productId);
              },
              icon: Icon(Icons.send, color: AppColors.kGreyColor, size: 25.sp),
            ),
          ),
          SizedBox(height: 15.h),

          ///comments
          Row(children: [Text('Comments', style: textStyle.Bold19)]),
          SizedBox(height: 15.h),

          /// comments list
          cubit.productComments.isEmpty
              ? Center(
                child: Text(
                  'No comments yet',
                  style: textStyle.Bold16.copyWith(color: AppColors.kGreyColor),
                ),
              )
              : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.productComments.length,
                itemBuilder:
                    (context, index) => CommentsWidget(
                      userName: cubit.productComments[index].userName,
                      userComment: cubit.productComments[index].comments,
                    ),
              ),
        ],
      ),
    );
  }
}
