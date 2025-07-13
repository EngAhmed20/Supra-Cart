import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/widgets/custom_text_form.dart';
import 'package:supra_cart/features/auth/ui/widgets/custom_text_button.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';
import '../../../../core/style/app_colors.dart';
import 'governorate_dropdown.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
class InfoForm extends StatefulWidget {
  InfoForm({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  String? selectedGovernorate;
  late TextEditingController mobileController;
  late TextEditingController cityController;
  late TextEditingController additionalInfoController;
  late GlobalKey<FormState> deliveryInfoFormKey;
  late AutovalidateMode deliveryInfoAutovalidateMode= AutovalidateMode.disabled;

  @override
  void initState() {
    final userInfo = widget.cubit.userInfoModel;

    mobileController = TextEditingController(text: userInfo?.mobilePhone ?? '');
    cityController = TextEditingController(text: userInfo?.city ?? '');
    additionalInfoController = TextEditingController(text: userInfo?.additionalInfo ?? '');
    selectedGovernorate = userInfo?.governorate;
    deliveryInfoFormKey = GlobalKey<FormState>();
    super.initState();

  }
  @override
  dispose() {
    mobileController.dispose();
    cityController.dispose();
    additionalInfoController.dispose();
    deliveryInfoAutovalidateMode = AutovalidateMode.disabled;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: deliveryInfoFormKey,
      autovalidateMode:deliveryInfoAutovalidateMode,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          CustomTextFormField(hintText: 'Mobile Number',controller: mobileController,
            keyboardType: TextInputType.phone,
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'Please enter your mobile number';
              } else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(val)) {
                return 'Please enter a valid mobile number';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          GovernorateDropdown(
            selectedGovernorate: selectedGovernorate,
            onChanged: (value) {
              selectedGovernorate = value;
            },
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'Please select a governorate';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(hintText: 'City',
            controller: cityController,
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'Please enter your city';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(hintText: 'Additional Info (Street, Building, etc.)',controller: additionalInfoController,),
          const SizedBox(height: 20),
          CustomTextButton(text: 'Save',style: textStyle.Bold19.copyWith(color: AppColors.kWhiteColor),verticalPadding: 5,horizontalPadding: 10, onPressed: (){
            if(deliveryInfoFormKey.currentState!.validate()){
              widget.cubit.saveOrUpdateDeliveryInfo(phone: mobileController.text,
                  governorate: selectedGovernorate!, city: cityController.text,additionalInfo: additionalInfoController.text);
              setState(() {
                deliveryInfoAutovalidateMode = AutovalidateMode.disabled;
              });
              Navigator.pop(context);
            }
            else{
              setState(() {
                deliveryInfoAutovalidateMode = AutovalidateMode.always;
              });
            }
          })
        ],
      ),
    );

  }
}