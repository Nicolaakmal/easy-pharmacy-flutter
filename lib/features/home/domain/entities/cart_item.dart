import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int id;
  final int userId;
  final int drugId;
  final int quantity;
  final String drugName;
  final int drugPrice;
  final String drugImage;

  CartItem({
    required this.id,
    required this.userId,
    required this.drugId,
    required this.quantity,
    required this.drugName,
    required this.drugPrice,
    required this.drugImage,
  });

  @override
  List<Object?> get props =>
      [id, userId, drugId, quantity, drugName, drugPrice, drugImage];
}
