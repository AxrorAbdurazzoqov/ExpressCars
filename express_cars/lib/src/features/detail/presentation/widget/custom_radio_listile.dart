import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_bloc.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomRadioListile extends StatefulWidget {
  final String title;
  const CustomRadioListile({super.key, required this.title});

  @override
  State<CustomRadioListile> createState() => _CustomRadioListileState();
}

class _CustomRadioListileState extends State<CustomRadioListile> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      value: widget.title,
      groupValue: context.watch<DetailBloc>().state.tariff,
      onChanged: (value) {
        BlocProvider.of<DetailBloc>(context, listen: false).add(ChooseTariffEvent(tariff: widget.title));
      },
      title: Text(
        widget.title,
        style: context.textTheme.titleMedium!.copyWith(color: AppColors.instance.black),
      ),
      tileColor: AppColors.instance.grey.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      activeColor: AppColors.instance.black,
    );
  }
}
