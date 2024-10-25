import 'package:equatable/equatable.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/features/onboarding/model/onboarding_model.dart';

class OnboardingState extends Equatable {
  final int index;

  final List<OnboardingModel> data = [
    OnboardingModel(
      image: AppVectors.instance.onboarding1,
      title: "Locate the Destination",
      description: "Your destination is at your fingertips. Open app & enter where you want to go",
    ),
    OnboardingModel(
      image: AppVectors.instance.onboarding2,
      title: "Select Your Root",
      description: "Get quick access to frequeant locations, and save them as favritos",
    ),
    OnboardingModel(
      image: AppVectors.instance.onboarding3,
      title: "Plan ahead and manage your money",
      description: "Setup your budget for each category so you in your control",
    ),
  ];

  OnboardingState({required this.index});


  @override
  List<Object?> get props => [
        data,
        index
      ];
}
