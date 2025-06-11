import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class NoOrdersYet extends StatelessWidget {
  const NoOrdersYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(Assets.assetsImagesNoOrdersYet),
    );
  }
}
