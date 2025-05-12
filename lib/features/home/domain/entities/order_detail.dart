import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final int id;
  final int orderId;
  final int drugId;
  final int quantity;
  final String drugName;
  final int drugPrice;
  final String drugImage;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.drugId,
    required this.quantity,
    required this.drugName,
    required this.drugPrice,
    required this.drugImage,
  });

  @override
  List<Object?> get props =>
      [id, orderId, drugId, quantity, drugName, drugPrice, drugImage];
}
