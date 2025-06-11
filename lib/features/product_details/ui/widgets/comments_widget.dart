import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({super.key, required this.userName, required this.userComment});
  final String userName;
  final String userComment;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 1,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: ListTile(
          contentPadding: EdgeInsets.all(5.h),
          leading: CircleAvatar(radius: 25.h,backgroundColor: Colors.white,child: Icon(Icons.person,size: 25.h,),
          ),
          title: Text(userName,style: textStyle.Bold16,),
          subtitle: Text(userComment,style: textStyle.semiBold16,),
        ),
      ),
    );
  }
}
