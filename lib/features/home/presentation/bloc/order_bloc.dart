// lib/features/home/presentation/bloc/order_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/get_paid_orders.dart';
import '../../domain/usecases/cancel_order.dart';
import '../../domain/usecases/get_cancelled_orders.dart';
import '../../home.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PayOrder payOrder;
  final GetOrderDetails getOrderDetails;
  final GetUnpaidOrders getUnpaidOrders;
  final GetPaidOrders getPaidOrders;
  final CancelOrder cancelOrder;
  final GetCancelledOrders getCancelledOrders;

  OrderBloc({
    required this.payOrder,
    required this.getOrderDetails,
    required this.getUnpaidOrders,
    required this.getPaidOrders,
    required this.cancelOrder,
    required this.getCancelledOrders,
  }) : super(OrderInitial()) {
    on<PayOrderEvent>(_onPayOrderEvent);
    on<LoadOrderDetailsEvent>(_onLoadOrderDetailsEvent);
    on<LoadUnpaidOrdersEvent>(_onLoadUnpaidOrdersEvent);
    on<LoadPaidOrdersEvent>(_onLoadPaidOrdersEvent);
    on<CancelOrderEvent>(_onCancelOrderEvent);
    on<LoadCancelledOrdersEvent>(_onLoadCancelledOrdersEvent);
  }

  Future<void> _onPayOrderEvent(
      PayOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final failureOrMessage = await payOrder(
      PayOrderParams(orderId: event.orderId, userId: event.userId),
    );
    emit(failureOrMessage.fold(
      (failure) => OrderError(message: _mapFailureToMessage(failure)),
      (message) => OrderPaid(message: message),
    ));
  }

  Future<void> _onLoadOrderDetailsEvent(
      LoadOrderDetailsEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final failureOrItems = await getOrderDetails(
      GetOrderDetailsParams(orderId: event.orderId, userId: event.userId),
    );
    emit(failureOrItems.fold(
      (failure) => OrderError(message: _mapFailureToMessage(failure)),
      (items) => OrderLoaded(items: items),
    ));
  }

  Future<void> _onLoadUnpaidOrdersEvent(
      LoadUnpaidOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final failureOrOrders = await getUnpaidOrders(event.userId);
    emit(failureOrOrders.fold(
      (failure) => OrderError(message: _mapFailureToMessage(failure)),
      (orders) => UnpaidOrdersLoaded(orders: orders),
    ));
  }

  Future<void> _onLoadPaidOrdersEvent(
      LoadPaidOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final failureOrOrders = await getPaidOrders(event.userId);
    emit(failureOrOrders.fold(
      (failure) => OrderError(message: _mapFailureToMessage(failure)),
      (orders) => PaidOrdersLoaded(orders: orders),
    ));
  }

  Future<void> _onCancelOrderEvent(
      CancelOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final failureOrMessage = await cancelOrder(
      CancelOrderParams(orderId: event.orderId, userId: event.userId),
    );
    emit(failureOrMessage.fold(
      (failure) => OrderError(message: _mapFailureToMessage(failure)),
      (message) => OrderCancelled(message: message),
    ));
  }

  Future<void> _onLoadCancelledOrdersEvent(
      LoadCancelledOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final failureOrOrders = await getCancelledOrders(event.userId);
    emit(failureOrOrders.fold(
      (failure) => OrderError(message: _mapFailureToMessage(failure)),
      (orders) => CancelledOrdersLoaded(orders: orders),
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
