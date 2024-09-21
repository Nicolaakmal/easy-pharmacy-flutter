import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetOrderDetails {
  final OrderRepository repository;

  GetOrderDetails(this.repository);

  @override
  Future<Either<Failure, List<OrderItem>>> call(
      GetOrderDetailsParams params) async {
    return await repository.getOrderDetails(params.orderId, params.userId);
  }
}

class GetOrderDetailsParams {
  final int orderId;
  final int userId;

  GetOrderDetailsParams({
    required this.orderId,
    required this.userId,
  });
}
