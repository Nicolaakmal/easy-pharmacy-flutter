class RegistrationResponseModel {
  final String message;

  RegistrationResponseModel({required this.message});

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseModel(
      message: json['message'],
    );
  }
}
