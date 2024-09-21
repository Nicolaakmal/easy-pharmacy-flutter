import 'package:dartz/dartz.dart';
import 'package:group_8_easy_pharmacy/features/features.dart';
import '../../../../core/errors/failures.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderItem>>> getOrderDetails(
      int orderId, int userId);
  Future<Either<Failure, String>> payOrder(int orderId, int userId);
  Future<Either<Failure, List<OrderStatus>>> getUnpaidOrders(int userId);
  Future<Either<Failure, List<OrderStatus>>> getPaidOrders(int userId);
  Future<Either<Failure, String>> cancelOrder(int orderId, int userId);
  Future<Either<Failure, List<OrderStatus>>> getCancelledOrders(int userId);
}
