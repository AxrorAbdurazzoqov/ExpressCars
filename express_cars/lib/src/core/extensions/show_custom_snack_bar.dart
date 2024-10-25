import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

extension ShowCustomSnackBar on BuildContext {
  void showCustomSnackBar({required Color color, required String title}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Row(
          children: [
            Icon(
              Icons.info,
              color: AppColors.instance.white,
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
