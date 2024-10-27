import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';

class CustomFeatureContainer extends StatelessWidget {
  final String icon;
  final String title;
  final String data;

  const CustomFeatureContainer({
    super.key,
    required this.data,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      height: context.getHeight(0.125),
      width: context.getWidth(0.3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.instance.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            height: 30,
            icon,
          ),
          Text(
            title,
            style: context.textTheme.titleSmall,
          ),
          Text(
            data,
            style: context.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}