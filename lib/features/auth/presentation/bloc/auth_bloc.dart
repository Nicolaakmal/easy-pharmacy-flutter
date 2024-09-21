import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final SharedPreferencesHelper sharedPreferencesHelper;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.sharedPreferencesHelper,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent); // AuthBloc menerima event RegisterEvent dan memprosesnya
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrUser = await loginUser(
        LoginParams(email: event.email, password: event.password));
    emit(await _eitherLoadedOrErrorState(failureOrUser));
  }

  //2. AuthBloc menerima RegisterEvent dan memprosesnya dg memanggil usecase RegisterUser
  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrMessage = await registerUser(RegisterParams(
      fullName: event.fullName,
      email: event.email,
      phoneNumber: event.phoneNumber,
      password: event.password,
      roleUser: event.roleUser,
    ));
    emit(_eitherRegisteredOrErrorState(failureOrMessage));
  }

  Future<AuthState> _eitherLoadedOrErrorState(
      Either<Failure, User> failureOrUser) async {
    return failureOrUser.fold(
      (failure) => AuthError(message: _mapFailureToMessage(failure)),
      (user) async {
        await sharedPreferencesHelper.saveToken(user.token);
        await sharedPreferencesHelper
            .saveUserData(json.encode(user.userData.toJson()));
        await sharedPreferencesHelper
            .saveUserId(user.userData.id);
        return AuthLoaded(user: user);
      },
    );
  }

  AuthState _eitherRegisteredOrErrorState(
      Either<Failure, String> failureOrMessage) {
    return failureOrMessage.fold(
      (failure) => AuthError(message: _mapFailureToMessage(failure)),
      (message) => AuthRegistered(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return 'Unexpected Error';
  }
}
