import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CachedImg extends StatelessWidget {
  const CachedImg({
    super.key, required this.imgUrl, required this.placeHolder,this.errWidget
  });
  final String imgUrl;
  final Widget placeHolder;
  final Widget? errWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: 250.h,
      fit: BoxFit.cover,
      placeholder: (context, url) => placeHolder,
      errorWidget: (context, url, error) => errWidget??Icon(Icons.error),);
  }
}
