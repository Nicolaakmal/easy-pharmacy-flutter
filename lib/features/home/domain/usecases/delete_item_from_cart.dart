import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class DeleteItemFromCart {
  final CartRepository repository;

  DeleteItemFromCart(this.repository);

  @override
  Future<Either<Failure, String>> call(DeleteItemFromCartParams params) async {
    return await repository.deleteCartItem(params.id, params.userId);
  }
}

class DeleteItemFromCartParams {
  final int id;
  final int userId;

  DeleteItemFromCartParams({
    required this.id,
    required this.userId,
  });
}
