
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../style/app_colors.dart';
Widget LoadingInkDrop({double?size}) =>  LoadingAnimationWidget.inkDrop(color: AppColors.kPrimaryColor, size: size??50.h);
Center Loading_body(BuildContext context) => Center(
  child: LoadingInkDrop(size: MediaQuery.of(context).size.width * 0.25),
);