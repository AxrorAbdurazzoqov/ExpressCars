
import 'package:express_cars/src/features/profile/presentation/bloc/bloc/profile_event.dart';
import 'package:express_cars/src/features/profile/presentation/bloc/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState(status: ProfileStatus.initial)) {
    on<ProfileEvent>((event, emit) {
    });
  }
}
