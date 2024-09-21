// lib/features/home/domain/usecases/cancel_order.dart
import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

class CancelOrder {
  final OrderRepository repository;

  CancelOrder(this.repository);

  @override
  Future<Either<Failure, String>> call(CancelOrderParams params) async {
    return await repository.cancelOrder(params.orderId, params.userId);
  }
}

class CancelOrderParams {
  final int orderId;
  final int userId;

  CancelOrderParams({
    required this.orderId,
    required this.userId,
  });
}
