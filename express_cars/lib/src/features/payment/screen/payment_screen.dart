import 'dart:async';

import 'package:express_cars/src/core/common/custom_elevated_button.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/core/extensions/show_custom_snack_bar.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_bloc.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PaymentScreen extends StatelessWidget {
  final String id;
  const PaymentScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saved Card',
              style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 20),
              color: AppColors.instance.lightGreenAccent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('2541 0039 8567 9850', style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                        Text('Axror Abdurrazzoqov', style: context.textTheme.titleMedium),
                      ],
                    ),
                    Image.asset(
                      height: 46,
                      AppVectors.instance.mastercard,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              onTap: () {
                context.read<DetailBloc>().add(
                      BookCarById(
                        id: id,
                        onSuccess: () async {
                          showDialog(
                            context: context,
                            builder: (context) => Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.all(50),
                              child: LottieBuilder.network(
                                'https://lottie.host/a2d75671-3458-4ee3-9d5f-1f886ad94215/epC22Wimku.json',
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                repeat: false,
                              ),
                            ),
                          );
                          Timer(
                            const Duration(seconds: 2),
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        onFailure: () => context.showCustomSnackBar(color: AppColors.instance.red, title: "Something went wrong"),
                      ),
                    );
              },
              title: 'Pay Now',
              height: context.getHeight(0.07),
              width: context.getWidth(1),
            ),
          ],
        ),
      ),
    );
  }
}
