import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String roleUser;

  RegisterEvent({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.roleUser,
  });

  @override
  List<Object?> get props => [fullName, email, phoneNumber, password, roleUser];
}
