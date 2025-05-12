import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, String>> addItemToCart(
      int userId, int drugId, int quantity);
  Future<Either<Failure, List<CartItem>>> getCartItems(int userId);
  Future<Either<Failure, CartItem>> updateCartItemQuantity(
      int id, int quantity);
  Future<Either<Failure, String>> deleteCartItem(int id, int userId);
  Future<Either<Failure, String>> checkoutOrder(int userId);
}
