import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String token;
  final UserData userData;

  User({required this.token, required this.userData});

  @override
  List<Object?> get props => [token, userData];
}

class UserData extends Equatable {
  final int id;
  final String email;
  final String fullName;

  UserData({required this.id, required this.email, required this.fullName});

  @override
  List<Object?> get props => [id, email, fullName];

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
    };
  }
}
