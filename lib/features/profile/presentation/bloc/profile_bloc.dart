import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../../../auth/domain/entities/user.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SharedPreferencesHelper sharedPreferencesHelper;

  ProfileBloc({required this.sharedPreferencesHelper})
      : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final token = await sharedPreferencesHelper.getToken();
        final userDataString = await sharedPreferencesHelper.getUserData();
        if (token != null && userDataString != null) {
          final userData = UserData.fromJson(json.decode(userDataString));
          emit(ProfileLoaded(user: User(token: token, userData: userData)));
        } else {
          emit(ProfileError(message: 'Failed to load user data'));
        }
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      print('LogoutEvent received');
      await sharedPreferencesHelper.clear();
      emit(ProfileInitial());
    });
  }
}
