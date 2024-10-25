import 'package:express_cars/src/features/onboarding/bloc/bloc/onboarding_event.dart';
import 'package:express_cars/src/features/onboarding/bloc/bloc/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState(index: 0)) {
    on<OnIndexChangedEvent>(
      (event, emit) {
        if (event.index > 2) {
          event.onSuccess();
          return;
        }
        emit(OnboardingState(index: event.index));
      },
    );
  }
}
