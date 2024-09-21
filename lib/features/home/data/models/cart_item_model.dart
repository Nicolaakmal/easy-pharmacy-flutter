import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    required int id,
    required int userId,
    required int drugId,
    required int quantity,
    required String drugName,
    required int drugPrice,
    required String drugImage,
  }) : super(
          id: id,
          userId: userId,
          drugId: drugId,
          quantity: quantity,
          drugName: drugName,
          drugPrice: drugPrice,
          drugImage: drugImage,
        );

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final drugJson = json['Drug'];
    return CartItemModel(
        id: json['id'],
        userId: json['userId'],
        drugId: json['drugId'],
        quantity: json['quantity'],
        drugName: drugJson != null ? drugJson['name'] ?? '' : '',
        drugPrice: drugJson != null ? drugJson['price'] ?? 0 : 0,
        drugImage: drugJson['image']);
  }
}
