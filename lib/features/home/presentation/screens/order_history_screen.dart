// lib/features/home/presentation/screens/order_history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../domain/entities/order_status.dart';
import '../bloc/order_bloc.dart';
import 'order_detail_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        elevation: 4,
        backgroundColor: Colors.blue[800],
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          indicatorColor: Colors.white, // white color for indicator slider Tab Bar
          indicatorWeight: 3.0,
          unselectedLabelColor: Colors.white70,
          labelColor: Colors.white,
          tabs: [
            const Tab(text: 'Unpaid'),
            const Tab(text: 'Completed'),
            const Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UnpaidTab(),
          CompletedTab(),
          CancelledTab(),
        ],
      ),
    );
  }
}

class UnpaidTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: SharedPreferencesHelper().getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          print('Error loading user ID: ${snapshot.error}');
          return const Center(child: Text('Error loading user ID'));
        } else {
          final userId = snapshot.data!;
          context.read<OrderBloc>().add(LoadUnpaidOrdersEvent(userId: userId));

          return BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UnpaidOrdersLoaded) {
                final orders = state.orders;
                if (orders.isEmpty) {
                  return const Center(child: Text('No unpaid orders.'));
                } else {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return UnpaidOrderCard(order: order);
                    },
                  );
                }
              } else if (state is OrderError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('No orders.'));
            },
          );
        }
      },
    );
  }
}

class CompletedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: SharedPreferencesHelper().getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          print('Error loading user ID: ${snapshot.error}');
          return const Center(child: Text('Error loading user ID'));
        } else {
          final userId = snapshot.data!;
          context.read<OrderBloc>().add(LoadPaidOrdersEvent(userId: userId));

          return BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PaidOrdersLoaded) {
                final orders = state.orders;
                if (orders.isEmpty) {
                  return const Center(child: Text('No completed orders.'));
                } else {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return OrderCard(order: order);
                    },
                  );
                }
              } else if (state is OrderError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('No orders.'));
            },
          );
        }
      },
    );
  }
}

class CancelledTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: SharedPreferencesHelper().getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          print('Error loading user ID: ${snapshot.error}');
          return const Center(child: Text('Error loading user ID'));
        } else {
          final userId = snapshot.data!;
          context
              .read<OrderBloc>()
              .add(LoadCancelledOrdersEvent(userId: userId));

          return BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CancelledOrdersLoaded) {
                final orders = state.orders;
                if (orders.isEmpty) {
                  return const Center(child: Text('No cancelled orders.'));
                } else {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return OrderCard(order: order);
                    },
                  );
                }
              } else if (state is OrderError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('No orders.'));
            },
          );
        }
      },
    );
  }
}

// class untuk Widget List Order History Unpaid (dilengkapi dengan fitur Cancel Order)
class UnpaidOrderCard extends StatelessWidget {
  final OrderStatus order;

  const UnpaidOrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('MMM dd, yyyy - h:mm a').format(order.updatedAt);

    return GestureDetector(
      onTap: () {
        context.read<OrderBloc>().add(
              LoadOrderDetailsEvent(
                orderId: order.id,
                userId: order.userId,
              ),
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailScreen(
              orderId: order.id,
              userId: order.userId,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${order.id}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () => _showCancelConfirmation(context),
                  child: const Text('Cancel Order'),
                ),
              ],
            ),
            Text(
              'Status: ${order.paidStatus}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            Text(
              'Order Date: $formattedDate',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Cancellation'),
          content: const Text('Are you sure you want to cancel this order?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<OrderBloc>().add(
                    CancelOrderEvent(orderId: order.id, userId: order.userId));
                context
                    .read<OrderBloc>()
                    .add(LoadCancelledOrdersEvent(userId: order.userId));
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

// class untuk Widget list Order History Completed dan Cancelled 
class OrderCard extends StatelessWidget {
  final OrderStatus order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('MMM dd, yyyy - h:mm a').format(order.updatedAt);

    return GestureDetector(
      onTap: () {
        context.read<OrderBloc>().add(
              LoadOrderDetailsEvent(
                orderId: order.id,
                userId: order.userId,
              ),
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailScreen(
              orderId: order.id,
              userId: order.userId,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Status: ${order.paidStatus}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            Text(
              'Order Date: $formattedDate',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
