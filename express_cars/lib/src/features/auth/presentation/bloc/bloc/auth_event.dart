part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [
        email
      ];
}

class UploadUserInfoEvent extends AuthEvent {
  final String fullname;
  final String email;
  final String username;
  final String defaultImage;

  const UploadUserInfoEvent({required this.fullname, required this.email, required this.username, this.defaultImage = 'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png'});
  @override
  List<Object?> get props => [];
}
