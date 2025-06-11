import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/widgets/custom_text_form.dart';
import 'package:supra_cart/features/auth/ui/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({super.key});
  static const String routeName = '/editName';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Edit Name',
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            CustomTextFormField(hintText: 'Write Your new name',validator: (String?val){
              if (val == null || val.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },),
            SizedBox(height: 20.h,),
              CustomTextButton(text: 'Update', onPressed: (){}),
            ],
          ),
        ),
      ),
    );
  }

}
