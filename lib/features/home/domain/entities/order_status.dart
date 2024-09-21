import 'package:equatable/equatable.dart';

class OrderStatus extends Equatable {
  final int id;
  final int userId;
  final String paidStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderStatus({
    required this.id,
    required this.userId,
    required this.paidStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, userId, paidStatus, createdAt, updatedAt];
}
