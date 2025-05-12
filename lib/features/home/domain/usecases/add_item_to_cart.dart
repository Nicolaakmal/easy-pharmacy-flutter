import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class AddItemToCart {
  final CartRepository repository;

  AddItemToCart(this.repository);

  @override
  Future<Either<Failure, String>> call(AddItemToCartParams params) async {
    return await repository.addItemToCart(
        params.userId, params.drugId, params.quantity);
  }
}

class AddItemToCartParams {
  final int userId;
  final int drugId;
  final int quantity;

  AddItemToCartParams(
      {required this.userId, required this.drugId, required this.quantity});
}
