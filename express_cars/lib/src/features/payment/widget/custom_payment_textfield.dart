import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:flutter/material.dart';

class CustomPaymentTextField extends StatelessWidget {
  final String labelText;
  const CustomPaymentTextField({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.instance.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.instance.lightGreenAccent),
        ),
        labelText: labelText,
        labelStyle: context.textTheme.titleMedium!.copyWith(
          color: AppColors.instance.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}