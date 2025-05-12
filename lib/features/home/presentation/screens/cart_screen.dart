import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_8_easy_pharmacy/features/home/presentation/screens/order_history_screen.dart';

import '../../../../core/core.dart';
import '../../home.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return FutureBuilder<int?>(
      future: SharedPreferencesHelper().getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: const CircularProgressIndicator()),
          );
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('Error loading user ID')),
          );
        } else {
          final userId = snapshot.data!;
          context.read<CartBloc>().add(LoadCartItemsEvent(userId));

          return Scaffold(
            appBar: AppBar(
              title: const Text('Cart'),
              centerTitle: true,
            ),
            body: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CartLoaded) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            final item = state.items[index];
                            return CartItemCard(item: item, userId: userId);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<CartBloc>()
                                    .add(CheckoutOrderEvent(userId));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme
                                    .primary, // blue color for button add to cart
                                foregroundColor: colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is CartError) {
                  return Center(child: Text(state.message));
                } else if (state is CartCheckedOut) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    // Navigate to Order History Screen with userId
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderHistoryScreen(),
                      ),
                    );
                  });
                }
                return const Center(child: Text('No items in cart.'));
              },
            ),
          );
        }
      },
    );
  }
}
