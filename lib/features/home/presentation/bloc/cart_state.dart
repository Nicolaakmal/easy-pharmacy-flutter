part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final String message;

  CartSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class CartLoaded extends CartState {
  final List<CartItem> items;

  CartLoaded({required this.items});

  @override
  List<Object> get props => [items];
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});

  @override
  List<Object> get props => [message];
}

class CartCheckedOut extends CartState {
  final String message;

  CartCheckedOut({required this.message});

  @override
  List<Object> get props => [message];
}
