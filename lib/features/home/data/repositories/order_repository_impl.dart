import 'package:dartz/dartz.dart';
import 'package:group_8_easy_pharmacy/features/features.dart';

import '../../../../core/core.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ApiServicesOrder apiServicesOrder;

  OrderRepositoryImpl(this.apiServicesOrder);

  @override
  Future<Either<Failure, List<OrderItem>>> getOrderDetails(
      int orderId, int userId) async {
    try {
      final items = await apiServicesOrder.getOrderDetails(orderId, userId);
      return Right(items);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> payOrder(int orderId, int userId) async {
    try {
      final response = await apiServicesOrder.payOrder(orderId, userId);
      return Right(response.message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderStatus>>> getUnpaidOrders(int userId) async {
    try {
      final orders = await apiServicesOrder.getUnpaidOrders(userId);
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderStatus>>> getPaidOrders(int userId) async {
    try {
      final orders = await apiServicesOrder.getPaidOrders(userId);
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> cancelOrder(int orderId, int userId) async {
    try {
      final response = await apiServicesOrder.cancelOrder(orderId, userId);
      return Right(response.message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderStatus>>> getCancelledOrders(
      int userId) async {
    try {
      final orders = await apiServicesOrder.getCancelledOrders(userId);
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
