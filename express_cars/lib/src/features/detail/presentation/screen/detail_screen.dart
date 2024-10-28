import 'package:express_cars/src/core/common/custom_elevated_button.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/detail/presentation/widget/custom_booking_sheet.dart';
import 'package:express_cars/src/features/detail/presentation/widget/custom_feature_container.dart';
import 'package:express_cars/src/features/detail/presentation/widget/custom_radio_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_bloc.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_event.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_state.dart';

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
                                return CustomBookingSheet(
                                  id: widget.id,
                                );
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