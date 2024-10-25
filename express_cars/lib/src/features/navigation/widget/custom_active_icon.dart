import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomActiveIcon extends StatelessWidget {
  final String icon;

  const CustomActiveIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const SizedBox(
          width: 25,
          height: 35,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: context.getHeight(0.02),
          child: Container(
            height: 30,
            width: 25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.instance.lightGreenAccent.withValues(alpha: 0.5),
                  AppColors.instance.white,
                ],
                stops: [
                  0.2,
                  1,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              AppColors.instance.lightGreenAccent,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
