import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';

class CustomSearchTextField extends StatelessWidget {
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const CustomSearchTextField({super.key, this.onTap, this.controller});



  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: TextField(
          onTap: onTap,
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.instance.white,
            hintText: 'Search',
            hintStyle: context.textTheme.titleMedium!.copyWith(
              color: AppColors.instance.grey,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.instance.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.instance.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            prefixIconConstraints: const BoxConstraints(minHeight: 40, minWidth: 40),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: SvgPicture.asset(AppVectors.instance.search),
            ),
          ),
        ),
      ),
    );
  }
}
