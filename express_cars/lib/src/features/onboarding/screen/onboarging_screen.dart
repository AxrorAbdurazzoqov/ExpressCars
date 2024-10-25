import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/features/onboarding/bloc/bloc/onboarding_bloc.dart';
import 'package:express_cars/src/features/onboarding/bloc/bloc/onboarding_state.dart';
import 'package:express_cars/src/features/onboarding/widget/draggable_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboargingScreen extends StatelessWidget {
  const OnboargingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<OnboardingBloc>(context).state;
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(bloc.data[bloc.index].image),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.getHeight(0.1),
                    ),
                    Text(
                      bloc.data[bloc.index].title,
                      style: context.textTheme.headlineLarge!.copyWith(color: AppColors.instance.white, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      bloc.data[bloc.index].description,
                      style: context.textTheme.titleMedium!.copyWith(color: AppColors.instance.white),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(
                        3,
                        (index) {
                          return index == bloc.index
                              ? AnimatedContainer(
                                  duration: Duration(milliseconds: 300), 
                                  curve: Curves.easeInOut,
                                  margin: EdgeInsets.only(right: 4),
                                  height: 5,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.instance.greenAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: CircleAvatar(radius: 2.5),
                                );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    DraggableNextButton(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}