import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hinText,
    this.isSecured = false,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  final TextEditingController controller;
  final String hinText;
  final bool isSecured;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isSecured;

  @override
  void initState() {
    super.initState();
    isSecured = widget.isSecured;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecured,
      style: context.textTheme.titleMedium,
      controller: widget.controller,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hinText,
        suffixIcon: widget.isSecured
            ? IconButton(
                onPressed: () {
                  isSecured = !isSecured;
                  setState(() {});
                },
                icon: Icon(isSecured ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        hintStyle: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w300, color: AppColors.instance.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.instance.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.instance.lightGreenAccent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.instance.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.instance.red),
        ),
      ),
    );
  }
}
