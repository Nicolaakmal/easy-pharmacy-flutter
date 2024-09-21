// lib/features/home/domain/usecases/get_paid_orders.dart
import 'package:dartz/dartz.dart';
import '../../../../../core/core.dart';
import '../entities/order_status.dart';
import '../repositories/order_repository.dart';

class GetPaidOrders {
  final OrderRepository repository;

  GetPaidOrders(this.repository);

  @override
  Future<Either<Failure, List<OrderStatus>>> call(int userId) async {
    return await repository.getPaidOrders(userId);
  }
}
