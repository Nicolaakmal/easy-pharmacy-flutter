import '../../domain/entities/order_detail.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel({
    required int id,
    required int orderId,
    required int drugId,
    required int quantity,
    required String drugName,
    required int drugPrice,
    required String drugImage,
  }) : super(
          id: id,
          orderId: orderId,
          drugId: drugId,
          quantity: quantity,
          drugName: drugName,
          drugPrice: drugPrice,
          drugImage: drugImage,
        );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final drugJson = json['Drug'];
    return OrderItemModel(
      id: json['id'],
      orderId: json['orderId'],
      drugId: json['drugId'],
      quantity: json['quantity'],
      drugName: drugJson != null ? drugJson['name'] ?? '' : '',
      drugPrice: drugJson != null ? drugJson['price'] ?? 0 : 0,
      drugImage: drugJson != null ? drugJson['image'] ?? '' : '',
    );
  }
}
