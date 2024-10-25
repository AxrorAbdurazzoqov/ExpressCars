part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];

  void add(UploadUserInfoEvent uploadUserInfoEvent) {}
}

final class AuthInitial extends AuthState {}
