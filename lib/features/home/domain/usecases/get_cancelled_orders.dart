// lib/features/home/domain/usecases/get_cancelled_orders.dart
import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

class GetCancelledOrders {
  final OrderRepository repository;

  GetCancelledOrders(this.repository);

  @override
  Future<Either<Failure, List<OrderStatus>>> call(int userId) async {
    return await repository.getCancelledOrders(userId);
  }
}
