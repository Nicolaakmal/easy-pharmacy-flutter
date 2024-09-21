import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/registration_response_model.dart';

abstract class ApiServicesRegistration {
  Future<RegistrationResponseModel> registerUser(String fullName, String email,
      String phoneNumber, String password, String roleUser);
}

class ApiServicesRegistrationImpl implements ApiServicesRegistration {
  final http.Client client;

  ApiServicesRegistrationImpl(this.client);

  // proses membuat HTTP POST ke endpoint Registrasi
  @override
  Future<RegistrationResponseModel> registerUser(String fullName, String email,
      String phoneNumber, String password, String roleUser) async {
    final response = await client.post(
      Uri.parse(registerEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'roleUser': roleUser,
      }),
    );

    // jika response == 200, maka Repository akan mengembalikan response pesan sukses
    // jika gagal, maka akan melempar ServerExceptions
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegistrationResponseModel.fromJson(json.decode(response.body));
    } else {
      var responseData = json.decode(response.body);
      throw ServerException(
          message: responseData['message'] ?? 'Failed to register user');
    }
  }
}
