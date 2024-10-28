import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:flutter/material.dart';

class CustomPlaceCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  const CustomPlaceCard({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 28,
          color: AppColors.instance.white,
        ),
        title: Text(
          title,
          style: context.textTheme.titleMedium!.copyWith(
            color: AppColors.instance.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: context.textTheme.titleMedium!.copyWith(
            color: AppColors.instance.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
