import '../../domain/entities/order_status.dart';

class OrderModel extends OrderStatus {
  OrderModel({
    required int id,
    required int userId,
    required String paidStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          userId: userId,
          paidStatus: paidStatus,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      paidStatus: json['paidStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
