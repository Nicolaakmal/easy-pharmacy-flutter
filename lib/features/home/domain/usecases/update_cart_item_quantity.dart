import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class UpdateCartItemQuantity {
  final CartRepository repository;

  UpdateCartItemQuantity(this.repository);

  @override
  Future<Either<Failure, CartItem>> call(
      UpdateCartItemQuantityParams params) async {
    return await repository.updateCartItemQuantity(params.id, params.quantity);
  }
}

class UpdateCartItemQuantityParams {
  final int id;
  final int quantity;

  UpdateCartItemQuantityParams({
    required this.id,
    required this.quantity,
  });
}
