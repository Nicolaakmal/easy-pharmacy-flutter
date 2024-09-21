import '../../domain/entities/user.dart';

class LoginResponseModel extends User {
  LoginResponseModel({
    required String token,
    required UserData userData,
  }) : super(
          token: token,
          userData: userData,
        );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'],
      userData: UserData.fromJson(json['userData']),
    );
  }
}
