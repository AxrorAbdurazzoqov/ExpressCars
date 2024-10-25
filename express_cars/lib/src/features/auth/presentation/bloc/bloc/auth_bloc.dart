import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:express_cars/src/features/auth/presentation/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<ResetPasswordEvent>((event, emit) async {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email);
    });
    on<UploadUserInfoEvent>((event, emit) {
      final UserInfoModel userInfoModel = UserInfoModel(name: event.username, imageUrl: event.defaultImage, followersCount: 0, followingCount: 0, publicPlaylists: []);
      FirebaseFirestore.instance.collection('users').add(userInfoModel.toJson());
    });
  }
}
