import 'package:express_cars/src/features/navigation/bloc/navigation_event.dart';
import 'package:express_cars/src/features/navigation/bloc/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on<OnNavbarIndexChangedEvent>(
      (event, emit) {
        emit(NavigationState(currentIndex: event.index));
      },
    );
  }
}
