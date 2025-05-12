import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../models/login_response_model.dart';

abstract class ApiServicesLogin {
  Future<LoginResponseModel> loginUser(String email, String password);
}

class ApiServicesLoginImpl implements ApiServicesLogin {
  final http.Client client;

  ApiServicesLoginImpl(this.client);

  @override
  Future<LoginResponseModel> loginUser(String email, String password) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.post(
      Uri.parse(loginEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      var responseData = json.decode(response.body);
      throw ServerException(
          message: responseData['message'] ?? 'Failed to login user');
    }
  }
}
