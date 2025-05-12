import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data.dart';

class CartRepositoryImpl implements CartRepository {
  final ApiServicesCart apiServicesCart;

  CartRepositoryImpl(this.apiServicesCart);

  @override
  Future<Either<Failure, String>> addItemToCart(
      int userId, int drugId, int quantity) async {
    try {
      final CartResponseModel response =
          await apiServicesCart.addItemToCart(userId, drugId, quantity);
      return Right(response.message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems(int userId) async {
    try {
      final List<CartItemModel> response =
          await apiServicesCart.getCartItems(userId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CartItem>> updateCartItemQuantity(
      int id, int quantity) async {
    try {
      final CartItemModel response =
          await apiServicesCart.updateCartItemQuantity(id, quantity);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteCartItem(int id, int userId) async {
    try {
      await apiServicesCart.deleteCartItem(id, userId);
      return const Right('Successfully deleted cart item');
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> checkoutOrder(int userId) async {
    try {
      await apiServicesCart.checkoutOrder(userId);
      return const Right('Order successfully placed');
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
