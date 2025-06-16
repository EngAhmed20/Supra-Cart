import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_text_styles.dart';

void customSnackBar({
  required BuildContext context,
  required String msg,
  bool isError = true,
  TextStyle? textStyleOverride,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              msg,
              style: textStyleOverride ??
                  textStyle.semiBold18.copyWith(color: Colors.white),
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10.w),
          Icon(
            isError ? Icons.error_outline:Icons.check_circle_outline,
            color: Colors.white,
            size: 25.h,
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      elevation: 8,
      backgroundColor:isError? Colors.red.shade700 : Colors.green.shade600,
    ),
  );
}

