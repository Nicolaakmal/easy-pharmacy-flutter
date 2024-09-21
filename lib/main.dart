import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_8_easy_pharmacy/features/home/domain/usecases/get_paid_orders.dart';
import 'package:group_8_easy_pharmacy/features/home/domain/usecases/cancel_order.dart';
import 'package:group_8_easy_pharmacy/features/home/domain/usecases/get_cancelled_orders.dart';
import 'package:http/http.dart' as http;

import 'core/utils/shared_preferences_helper.dart';
import 'features/features.dart';
import 'features/home/data/repositories/order_repository_impl.dart';
import 'main_screen.dart';
import 'shared/shared.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryImpl(
      apiServicesLogin: ApiServicesLoginImpl(http.Client()),
      apiServicesRegistration: ApiServicesRegistrationImpl(http.Client()),
    );

    final drugRepository = DrugRepositoryImpl(
      ApiServicesDrugImpl(http.Client()),
    );

    final cartRepository = CartRepositoryImpl(
      ApiServicesCartImpl(http.Client()),
    );

    final orderRepository = OrderRepositoryImpl(
      ApiServicesOrderImpl(http.Client()),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            loginUser: LoginUser(authRepository),
            registerUser: RegisterUser(authRepository),
            sharedPreferencesHelper: SharedPreferencesHelper(),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            sharedPreferencesHelper: SharedPreferencesHelper(),
          ),
        ),
        BlocProvider(
          create: (context) => DrugBloc(
            GetDrugs(drugRepository),
          ),
        ),
        BlocProvider(
          create: (context) => CartBloc(
            AddItemToCart(cartRepository),
            GetCartItems(cartRepository),
            UpdateCartItemQuantity(cartRepository),
            DeleteItemFromCart(cartRepository),
            CheckoutOrder(cartRepository),
          ),
        ),
        BlocProvider(
          create: (context) => OrderBloc(
            getOrderDetails: GetOrderDetails(orderRepository),
            payOrder: PayOrder(orderRepository),
            getUnpaidOrders: GetUnpaidOrders(orderRepository),
            getPaidOrders: GetPaidOrders(orderRepository),
            cancelOrder: CancelOrder(orderRepository),
            getCancelledOrders: GetCancelledOrders(orderRepository),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/profile': (context) => ProfileScreen(),
          '/main': (context) => const MainScreen(),
          '/cart': (context) => const CartScreen(),
          // '/summary': (context) => const SummaryScreen(),
        },
      ),
    );
  }
}
