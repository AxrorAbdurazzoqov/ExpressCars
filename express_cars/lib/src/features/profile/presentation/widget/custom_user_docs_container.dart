import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomUserDocsContainer extends StatelessWidget {
  final IconData icon;
  final String title;

  const CustomUserDocsContainer({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 5),
          ],
          color: AppColors.instance.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 5),
            Text(title),
          ],
        ));
  }
}