import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  //3. usecase RegisterUser memanggil method register di AuthRepository 
  // untuk mengirim data ke Server
  @override
  Future<Either<Failure, String>> call(RegisterParams params) async {
    return await repository.register(params.fullName, params.email,
        params.phoneNumber, params.password, params.roleUser);
  }
}

class RegisterParams {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String roleUser;

  RegisterParams({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.roleUser,
  });
}
