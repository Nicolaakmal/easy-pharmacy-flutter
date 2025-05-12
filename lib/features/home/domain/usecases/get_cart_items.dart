import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

class GetCartItems {
  final CartRepository repository;

  GetCartItems(this.repository);

  @override
  Future<Either<Failure, List<CartItem>>> call(int userId) async {
    return await repository.getCartItems(userId);
  }
}
