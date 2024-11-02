import 'package:express_cars/src/core/common/custom_elevated_button.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/detail/presentation/screen/select_adress_screen.dart';
import 'package:flutter/material.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:intl/intl.dart';

class CustomBookingSheet extends StatefulWidget {
  final String id;
  const CustomBookingSheet({
    super.key,
    required this.id,
  });

  @override
  State<CustomBookingSheet> createState() => _CustomBookingSheetState();
}

class _CustomBookingSheetState extends State<CustomBookingSheet> {
  DateTime dateTime = DateTime.now();
  int selectedDate = 0;
  int selectedTime = 0;
  final List<String> times = [
    "09:00 AM",
    "12:00 PM",
    "15:00 PM",
    "16:00 PM"
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
                    color: AppColors.instance.grey.withOpacity(0.2),
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
                      color: index == selectedDate ? AppColors.instance.grey.withOpacity(0.15) : AppColors.instance.white,
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
                      color: index == selectedTime ? AppColors.instance.grey.withOpacity(0.15) : AppColors.instance.white,
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
                builder: (context) => SelectAdressScreen(
                  id: widget.id,
                ),
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
