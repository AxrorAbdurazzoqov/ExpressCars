import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.title,
    this.borderRadius = 30,
    required this.height,
    required this.width,
    this.fontSize = 22,
    this.color,
  });

  final VoidCallback onTap;
  final String title;
  final double borderRadius;
  final double height;
  final double width;
  final double fontSize;
  final int? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(Size(width, height)),
        foregroundColor: WidgetStatePropertyAll(AppColors.instance.white),
        backgroundColor: WidgetStatePropertyAll(color == null ? AppColors.instance.greenAccent : Color(color!)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))),
      ),
      child: Text(title, style: context.textTheme.titleMedium!.copyWith(fontSize: fontSize, fontWeight: FontWeight.w500)),
    );
  }
}
