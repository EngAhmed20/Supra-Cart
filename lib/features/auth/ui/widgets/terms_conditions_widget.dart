import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import 'custom_check_box.dart';

class TermsAndConditionWidget extends StatefulWidget {
  const TermsAndConditionWidget({super.key, required this.onChecked});
  final ValueChanged<bool> onChecked;


  @override
  State<TermsAndConditionWidget> createState() => _TermsAndConditionWidgetState();
}

class _TermsAndConditionWidgetState extends State<TermsAndConditionWidget> {
  bool isTermsAccepted=false;
  var url=Uri.https("www.termsfeed.com","/live/43bf675d-7b68-454a-bf45-7ec1db0cf6a4",);
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset:const Offset(6,0),
      child: Row(
        children: [
          CustomCheckBox(isChecked:isTermsAccepted,onChecked: (value){
            isTermsAccepted=value;
            widget.onChecked(value);
           setState(() {

           });
          },),
          SizedBox(width: 16.w),

          Expanded(
            child: Transform.translate(
              offset: const Offset(0,8),
              child: Text.rich(
                TextSpan(
                  children:[
                    TextSpan(text: "By creating an account, you agree to our ",style: textStyle.semiBold13),
                    TextSpan(text:"Terms and Conditions",
                        recognizer:TapGestureRecognizer()..onTap=(){
                          launchUrl(url);
                        },
                        style: textStyle.semiBold13.copyWith(color: AppColors.kLightPrimaryColor)),

                  ]
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
