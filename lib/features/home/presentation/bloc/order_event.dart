// lib/features/home/presentation/bloc/order_event.dart
part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PayOrderEvent extends OrderEvent {
  final int orderId;
  final int userId;

  PayOrderEvent({required this.orderId, required this.userId});

  @override
  List<Object> get props => [orderId, userId];
}

class LoadOrderDetailsEvent extends OrderEvent {
  final int orderId;
  final int userId;

  LoadOrderDetailsEvent({required this.orderId, required this.userId});

  @override
  List<Object> get props => [orderId, userId];
}

class LoadUnpaidOrdersEvent extends OrderEvent {
  final int userId;

  LoadUnpaidOrdersEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoadPaidOrdersEvent extends OrderEvent {
  final int userId;

  LoadPaidOrdersEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class PaidOrdersLoaded extends OrderState {
  final List<OrderStatus> orders;

  PaidOrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class CancelOrderEvent extends OrderEvent {
  final int orderId;
  final int userId;

  CancelOrderEvent({required this.orderId, required this.userId});

  @override
  List<Object> get props => [orderId, userId];
}

class LoadCancelledOrdersEvent extends OrderEvent {
  final int userId;

  LoadCancelledOrdersEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
