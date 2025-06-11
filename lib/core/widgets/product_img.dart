import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cached_img.dart';
import 'loadibg_ink_drop.dart';

class ProductPicture extends StatelessWidget {
  const ProductPicture({
    super.key, required this.imgUrl,
  });
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.r),
        bottomRight: Radius.circular(10.r),
      ),
      child: CachedImg(
        imgUrl:imgUrl,
        placeHolder: Container(
          width: double.infinity,
          height: 150.h,
          child: Center(child: LoadingInkDrop()),
        ),
      ),
    );
  }
}
