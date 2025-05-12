import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class CheckoutOrder {
  final CartRepository repository;

  CheckoutOrder(this.repository);

  @override
  Future<Either<Failure, String>> call(int userId) async {
    final result = await repository.checkoutOrder(userId);
    // result.fold(
    //   (failure) => print('Checkout order failed: ${failure.message}'),
    //   (message) => print('Checkout order success: $message'),
    // );
    return result;
  }
}
