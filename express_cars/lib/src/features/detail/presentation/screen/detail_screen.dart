import 'package:express_cars/src/core/common/custom_elevated_button.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/detail/presentation/screen/select_adress_screen.dart';
import 'package:express_cars/src/features/detail/presentation/widget/custom_feature_container.dart';
import 'package:express_cars/src/features/detail/presentation/widget/custom_radio_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_bloc.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_event.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_state.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  final String name;
  const DetailScreen({super.key, required this.id, required this.name});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? tariff;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailBloc>(context).add(FetchCarByIdEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state.status == DetailStatus.success) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      state.model!.imageUrl,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          size: 28,
                          Icons.star_rounded,
                          color: AppColors.instance.amber,
                        ),
                        Text(
                          '${(state.model!.reviews.reduce((a, b) => a + b)) / state.model!.reviews.length}',
                          style: context.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Text(
                      '${state.model!.brand} ${state.model!.model} ${state.model!.year}',
                      style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomFeatureContainer(
                          icon: AppVectors.instance.motor,
                          title: 'Engine',
                          data: '${state.model!.features.engine}hp',
                        ),
                        CustomFeatureContainer(
                          icon: AppVectors.instance.automatic,
                          title: 'Transmission',
                          data: state.model!.features.transmission,
                        ),
                        CustomFeatureContainer(
                          icon: AppVectors.instance.fuel,
                          title: 'Fuel Type',
                          data: state.model!.features.fuelType,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Features',
                      style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Card.outlined(
                      child: ListTile(
                        leading: Icon(Icons.airline_seat_recline_extra_rounded),
                        title: Text('Seats'),
                        trailing: Text(state.model!.features.seats.toString()),
                      ),
                    ),
                    Card.outlined(
                      child: ListTile(
                        leading: Icon(Icons.ac_unit_outlined),
                        title: Text('Air Conditioner'),
                        trailing: Text(state.model!.features.airConditioner ? 'Yes' : 'No'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (state.model!.reviews.isNotEmpty)
                      Text(
                        'Tariffs',
                        style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(height: 10),
                    CustomRadioListile(title: '\$${state.model!.pricePerDay}/day'),
                    const SizedBox(height: 10),
                    CustomRadioListile(title: '\$${state.model!.pricePerWeek}/week'),
                    const SizedBox(height: 10),
                    CustomRadioListile(title: '\$${state.model!.pricePerMonth}/month'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          textAlign: TextAlign.start,
                          TextSpan(
                            text: 'Total Price\n',
                            style: context.textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: context.watch<DetailBloc>().state.tariff ?? '*',
                                style: context.textTheme.titleLarge!.copyWith(
                                  color: AppColors.instance.lightGreenAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomElevatedButton(
                          onTap: () {
                            if (BlocProvider.of<DetailBloc>(context).state.tariff == null) return;
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return CustomBookingSheet();
                              },
                            );
                          },
                          title: 'Book now',
                          color: AppColors.instance.greenAccent,
                          height: context.getHeight(0.09),
                          width: context.getWidth(0.5),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else if (state.status == DetailStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? 'Something went wrong'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}

class CustomBookingSheet extends StatefulWidget {
  const CustomBookingSheet({
    super.key,
  });

  @override
  State<CustomBookingSheet> createState() => _CustomBookingSheetState();
}

class _CustomBookingSheetState extends State<CustomBookingSheet> {
  DateTime dateTime = DateTime.now();
  int selectedDate = 0;
  int selectedTime = 0;
  final List<String> times = [
    "07:00 AM",
    "09:00 AM",
    "11:00 AM",
    "12:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.instance.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
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
          SizedBox(height: 8),
          Text(
            'Select Date',
            style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: '${DateFormat.MMMMd().format(dateTime)}\n',
                  style: context.textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: DateFormat.EEEE().format(dateTime),
                      style: context.textTheme.titleMedium!.copyWith(color: AppColors.instance.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  dateTime = await showDatePicker(
                        context: context,
                        firstDate: dateTime,
                        lastDate: dateTime.copyWith(year: dateTime.year + 10),
                      ) ??
                      DateTime.now();
                  setState(() {});
                },
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.instance.grey.withValues(alpha: 0.2),
                  ),
                  child: Icon(Icons.calendar_month_rounded),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: index == selectedDate ? AppColors.instance.grey.withValues(alpha: 0.15) : AppColors.instance.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: index == selectedDate ? AppColors.instance.green : AppColors.instance.grey,
                        width: index == selectedDate ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          (dateTime.day + index).toString(),
                          style: context.textTheme.titleMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: index == selectedDate ? AppColors.instance.green : AppColors.instance.black,
                          ),
                        ),
                        Text(
                          DateFormat.EEEE().format(dateTime.copyWith(day: dateTime.day + index)).substring(0, 3),
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: index == selectedDate ? AppColors.instance.green : AppColors.instance.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Select Time',
            style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              times.length,
              (index) {
                bool isSelected = selectedTime == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      color: index == selectedTime ? AppColors.instance.grey.withValues(alpha: 0.15) : AppColors.instance.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: index == selectedTime ? AppColors.instance.green : AppColors.instance.grey,
                        width: index == selectedTime ? 1.5 : 1,
                      ),
                    ),
                    child: Text(
                      times[index],
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: isSelected ? AppColors.instance.green : AppColors.instance.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          CustomElevatedButton(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectAdressScreen(),
              ),
            ),
            title: 'Confirm',
            height: context.getHeight(0.075),
            width: context.getWidth(1),
          ),
        ],
      ),
    );
  }
}
