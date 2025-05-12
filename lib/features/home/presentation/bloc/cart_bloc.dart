import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../home.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddItemToCart addItemToCart;
  final GetCartItems getCartItems;
  final UpdateCartItemQuantity updateCartItemQuantity;
  final DeleteItemFromCart deleteItemFromCart;
  final CheckoutOrder checkoutOrder;

  CartBloc(this.addItemToCart, this.getCartItems, this.updateCartItemQuantity,
      this.deleteItemFromCart, this.checkoutOrder)
      : super(CartInitial()) {
    on<AddItemToCartEvent>(_onAddItemToCartEvent);
    on<LoadCartItemsEvent>(_onLoadCartItemsEvent);
    on<UpdateCartItemQuantityEvent>(_onUpdateCartItemQuantityEvent);
    on<DeleteItemFromCartEvent>(_onDeleteItemFromCartEvent);
    on<CheckoutOrderEvent>(_onCheckoutOrderEvent);
  }

  Future<void> _onAddItemToCartEvent(
      AddItemToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final failureOrMessage = await addItemToCart(AddItemToCartParams(
      userId: event.userId,
      drugId: event.drugId,
      quantity: event.quantity,
    ));
    emit(failureOrMessage.fold(
      (failure) => CartError(message: _mapFailureToMessage(failure)),
      (message) => CartSuccess(message: message),
    ));
    add(LoadCartItemsEvent(event.userId)); // Reload cart items after adding
  }

  Future<void> _onLoadCartItemsEvent(
      LoadCartItemsEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final failureOrItems = await getCartItems(event.userId);
    emit(failureOrItems.fold(
      (failure) => CartError(message: _mapFailureToMessage(failure)),
      (items) => CartLoaded(items: items),
    ));
  }

  Future<void> _onUpdateCartItemQuantityEvent(
      UpdateCartItemQuantityEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      emit(CartLoading());
      final failureOrItem = await updateCartItemQuantity(
          UpdateCartItemQuantityParams(id: event.id, quantity: event.quantity));
      emit(failureOrItem.fold(
        (failure) => CartError(message: _mapFailureToMessage(failure)),
        (item) {
          final updatedItems = currentState.items.map((cartItem) {
            return cartItem.id == item.id ? item : cartItem;
          }).toList();
          return CartLoaded(items: updatedItems);
        },
      ));
    }
  }

  Future<void> _onDeleteItemFromCartEvent(
      DeleteItemFromCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final failureOrMessage = await deleteItemFromCart(
        DeleteItemFromCartParams(id: event.id, userId: event.userId));
    emit(failureOrMessage.fold(
      (failure) => CartError(message: _mapFailureToMessage(failure)),
      (message) => CartSuccess(message: message),
    ));
    add(LoadCartItemsEvent(event.userId)); // Reload cart items after deletion
  }

  Future<void> _onCheckoutOrderEvent(
      CheckoutOrderEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final failureOrMessage = await checkoutOrder(event.userId);
    emit(failureOrMessage.fold(
      (failure) => CartError(message: _mapFailureToMessage(failure)),
      (message) => CartSuccess(message: message),
    ));
    // Navigate to Order History Screen with userId
    if (state is CartSuccess) {
      emit(CartCheckedOut(message: (state as CartSuccess).message));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return 'Unexpected Error';
  }
}
