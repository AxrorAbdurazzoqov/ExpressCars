import 'package:express_cars/src/core/common/custom_elevated_button.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomFilterWidget extends StatefulWidget {
  final double minPrice;
  final double maxPrice;
  final List<String> types;

  const CustomFilterWidget({super.key, required this.minPrice, required this.maxPrice, required this.types});

  @override
  State<CustomFilterWidget> createState() => _CustomFilterWidgetState();
}

class _CustomFilterWidgetState extends State<CustomFilterWidget> {
  late RangeValues filterValues;

  final List<String> vehicleCharacteristics = [
    'Air-conditioning',
    'Automatic',
    'Manual'
  ];

  late RangeValues filteredValues;
  late List<bool> filteredTypes;
  List<bool> filteredVehicleCharacteristics = List.generate(3, (index) => false);

  @override
  void initState() {
    super.initState();
    filterValues = RangeValues(widget.minPrice, widget.maxPrice);
    filteredValues = RangeValues(widget.minPrice, widget.maxPrice);
    filteredTypes = List.generate(widget.types.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getHeight(0.7),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.instance.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 6,
                width: 85,
                decoration: BoxDecoration(
                  color: AppColors.instance.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: CustomTitle(title: 'Price Range'),
            ),
            SizedBox(
              height: 30,
              width: double.infinity,
              child: RangeSlider(
                onChangeEnd: (value) {
                  filteredValues = value;
                },
                values: filterValues,
                min: 0,
                max: widget.maxPrice + widget.minPrice,
                divisions: (widget.maxPrice ~/ 1000).toInt(),
                activeColor: AppColors.instance.greenAccent,
                onChanged: (RangeValues values) {
                  setState(() {
                    filterValues = values;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.instance.lightGreenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('\$${filterValues.start.round()}'),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.instance.lightGreenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('\$${filterValues.end.round()}'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTitle(title: 'Types'),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 5,
              children: List.generate(
                widget.types.length,
                (index) => ChoiceChip(
                  selected: filteredTypes[index],
                  label: Text(widget.types[index]),
                  onSelected: (value) {
                    setState(() {
                      filteredTypes[index] = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTitle(title: 'Vehicle characteristics'),
            ),
            Wrap(
              spacing: 5,
              children: List.generate(
                vehicleCharacteristics.length,
                (index) => ChoiceChip(
                  selected: filteredVehicleCharacteristics[index],
                  label: Text(vehicleCharacteristics[index]),
                  onSelected: (value) {
                    setState(() {
                      filteredVehicleCharacteristics[index] = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  onTap: () {
                    filteredTypes = List.generate(widget.types.length, (index) => false);
                    filteredVehicleCharacteristics = List.generate(3, (index) => false);
                    filterValues = RangeValues(widget.minPrice, widget.maxPrice);
                    setState(() {});
                  },
                  title: 'Clear All',
                  height: 60,
                  width: 150,
                  color: AppColors.instance.grey,
                  borderRadius: 10,
                ),
                CustomElevatedButton(
                  onTap: () {
                    final selectedTypes = widget.types.asMap().entries.where((entry) => filteredTypes[entry.key]).map((entry) => entry.value).toList();

                    final selectedCharacteristics = vehicleCharacteristics.asMap().entries.where((entry) => filteredVehicleCharacteristics[entry.key]).map((entry) => entry.value).toList();

                    context.read<HomeBloc>().add(
                          OnCustomDetailFilterEvent(
                            rangeValues: filteredValues,
                            filters: selectedTypes,
                            features: selectedCharacteristics,
                          ),
                        );
                    Navigator.pop(context);
                  },
                  title: 'Apply',
                  height: 60,
                  width: 150,
                  borderRadius: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomTitle extends StatelessWidget {
  final String title;
  const CustomTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
