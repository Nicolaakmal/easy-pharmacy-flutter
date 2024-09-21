// lib/features/home/domain/usecases/get_unpaid_orders.dart
import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

class GetUnpaidOrders {
  final OrderRepository repository;

  GetUnpaidOrders(this.repository);

  @override
  Future<Either<Failure, List<OrderStatus>>> call(int userId) async {
    return await repository.getUnpaidOrders(userId);
  }
}
