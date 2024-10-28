import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:flutter/material.dart';

class CustomAddressRadioListTile extends StatelessWidget {
  final String image;
  final String title;
  final String address;
  final String? groupValue;
  final bool isSelected;

  const CustomAddressRadioListTile({
    super.key,
    required this.image,
    required this.title,
    required this.address,
    required this.isSelected,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: RadioListTile(
        value: 'Home',
        selected: isSelected,
        groupValue: groupValue,
        secondary: SizedBox(
          height: 80,
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                image,
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          address,
          style: context.textTheme.titleSmall!.copyWith(color: AppColors.instance.grey),
        ),
        onChanged: (val) {},
      ),
    );
  }
}