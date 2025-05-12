// lib/features/home/domain/usecases/pay_order.dart
import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

class PayOrder {
  final OrderRepository repository;

  PayOrder(this.repository);

  @override
  Future<Either<Failure, String>> call(PayOrderParams params) async {
    return await repository.payOrder(params.orderId, params.userId);
  }
}

class PayOrderParams {
  final int orderId;
  final int userId;

  PayOrderParams({
    required this.orderId,
    required this.userId,
  });
}
