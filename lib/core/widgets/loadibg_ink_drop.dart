import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../style/app_colors.dart';
Widget LoadingInkDrop() =>  LoadingAnimationWidget.inkDrop(color: AppColors.kPrimaryColor, size: 50.h);
