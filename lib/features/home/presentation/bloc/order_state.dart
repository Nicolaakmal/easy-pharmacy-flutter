// lib/features/home/presentation/bloc/order_state.dart
part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderItem> items;

  OrderLoaded({required this.items});

  @override
  List<Object> get props => [items];
}

class OrderError extends OrderState {
  final String message;

  OrderError({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderPaid extends OrderState {
  final String message;

  OrderPaid({required this.message});

  @override
  List<Object> get props => [message];
}

class UnpaidOrdersLoaded extends OrderState {
  final List<OrderStatus> orders;

  UnpaidOrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class CancelledOrdersLoaded extends OrderState {
  final List<OrderStatus> orders;

  CancelledOrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrderCancelled extends OrderState {
  final String message;

  OrderCancelled({required this.message});

  @override
  List<Object> get props => [message];
}
