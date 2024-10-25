import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:flutter/material.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              height: 50,
              width: 50,
              AppVectors.instance.logo,
            ),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: 'CA',
                style: context.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: "R",
                    style: context.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, color: AppColors.instance.greenAccent),
                  ),
                  TextSpan(
                    text: "S",
                    style: context.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: 'Welcome Back 👋\nto',
            style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: " CARZ",
                style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold, color: AppColors.instance.greenAccent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
