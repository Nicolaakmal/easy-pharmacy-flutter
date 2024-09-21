// lib/features/home/data/data_sources/api_services_order.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/core.dart';
import '../data.dart';
import '../models/order_status_model.dart';

abstract class ApiServicesOrder {
  Future<OrderResponseModel> payOrder(int orderId, int userId);
  Future<List<OrderItemModel>> getOrderDetails(int orderId, int userId);
  Future<List<OrderModel>> getUnpaidOrders(int userId);
  Future<List<OrderModel>> getPaidOrders(int userId);
  Future<OrderResponseModel> cancelOrder(int orderId, int userId);
  Future<List<OrderModel>> getCancelledOrders(int userId);
}

class ApiServicesOrderImpl implements ApiServicesOrder {
  final http.Client client;

  ApiServicesOrderImpl(this.client);

  @override
  Future<OrderResponseModel> payOrder(int orderId, int userId) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.post(
      Uri.parse(payOrderEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!,
      },
      body: jsonEncode(<String, dynamic>{
        'orderId': orderId,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      return OrderResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(
          message:
              json.decode(response.body)['message'] ?? 'Failed to pay order');
    }
  }

  @override
  Future<List<OrderItemModel>> getOrderDetails(int orderId, int userId) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.post(
      Uri.parse(getOrderDetailsEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!,
      },
      body: jsonEncode(<String, dynamic>{
        'orderId': orderId,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => OrderItemModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message: json.decode(response.body)['message'] ??
              'Failed to load order details');
    }
  }

  @override
  Future<List<OrderModel>> getUnpaidOrders(int userId) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.get(
      Uri.parse('$getUnpaidOrdersEndpoint/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message: json.decode(response.body)['message'] ??
              'Failed to load unpaid orders');
    }
  }

  @override
  Future<List<OrderModel>> getPaidOrders(int userId) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.get(
      Uri.parse('$getPaidOrdersEndpoint/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message: json.decode(response.body)['message'] ??
              'Failed to load paid orders');
    }
  }

  @override
  Future<OrderResponseModel> cancelOrder(int orderId, int userId) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.post(
      Uri.parse(cancelOrderEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!,
      },
      body: jsonEncode(<String, dynamic>{
        'orderId': orderId,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      return OrderResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(
          message: json.decode(response.body)['message'] ??
              'Failed to cancel order');
    }
  }

  @override
  Future<List<OrderModel>> getCancelledOrders(int userId) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.get(
      Uri.parse('$getCancelledOrdersEndpoint/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message: json.decode(response.body)['message'] ??
              'Failed to load cancelled orders');
    }
  }
}
