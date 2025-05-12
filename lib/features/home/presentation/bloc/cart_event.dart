part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddItemToCartEvent extends CartEvent {
  final int userId;
  final int drugId;
  final int quantity;

  AddItemToCartEvent({
    required this.userId,
    required this.drugId,
    required this.quantity,
  });

  @override
  List<Object> get props => [userId, drugId, quantity];
}

class LoadCartItemsEvent extends CartEvent {
  final int userId;

  LoadCartItemsEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateCartItemQuantityEvent extends CartEvent {
  final int id;
  final int quantity;
  final int userId;

  UpdateCartItemQuantityEvent({
    required this.id,
    required this.quantity,
    required this.userId,
  });

  @override
  List<Object> get props => [id, quantity, userId];
}

class DeleteItemFromCartEvent extends CartEvent {
  final int id;
  final int userId;

  DeleteItemFromCartEvent({
    required this.id,
    required this.userId,
  });

  @override
  List<Object> get props => [id, userId];
}

class CheckoutOrderEvent extends CartEvent {
  final int userId;

  CheckoutOrderEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
