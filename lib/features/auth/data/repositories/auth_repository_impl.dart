import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/api_services_login.dart';
import '../data_sources/api_services_registration.dart';
import '../models/login_response_model.dart';
import '../models/registration_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiServicesLogin apiServicesLogin;
  final ApiServicesRegistration apiServicesRegistration;

  AuthRepositoryImpl({
    required this.apiServicesLogin,
    required this.apiServicesRegistration,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final LoginResponseModel loginResponse =
          await apiServicesLogin.loginUser(email, password);
      return Right(loginResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  // 4. repository menggunakan ApiServicesRegistration untuk membuat
  // permintaan HTTP POST ke endpoint Registrasi
  @override
  Future<Either<Failure, String>> register(String fullName, String email,
      String phoneNumber, String password, String roleUser) async {
    try {
      final RegistrationResponseModel registerResponse =
          await apiServicesRegistration.registerUser(
              fullName, email, phoneNumber, password, roleUser);
      return Right(registerResponse.message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
