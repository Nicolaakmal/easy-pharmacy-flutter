import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/core.dart';
import '../data.dart';

abstract class ApiServicesCart {
  Future<CartResponseModel> addItemToCart(int userId, int drugId, int quantity);
  Future<List<CartItemModel>> getCartItems(int userId);
  Future<CartItemModel> updateCartItemQuantity(int id, int quantity);
  Future<void> deleteCartItem(int id, int userId);
  Future<void> checkoutOrder(int userId);
}

class ApiServicesCartImpl implements ApiServicesCart {
  final http.Client client;

  ApiServicesCartImpl(this.client);

  @override
  Future<CartResponseModel> addItemToCart(
      int userId, int drugId, int quantity) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.post(
      Uri.parse(addItemToCartEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'drugId': drugId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      return CartResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ??
            'Failed to add item to cart',
      );
    }
  }

  @override
  Future<List<CartItemModel>> getCartItems(int userId) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.get(
      Uri.parse('$getCartItemsEndpoint/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => CartItemModel.fromJson(json)).toList();
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ??
            'Failed to load cart items',
      );
    }
  }

  @override
  Future<CartItemModel> updateCartItemQuantity(int id, int quantity) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.put(
      Uri.parse(updateCartItemQuantityEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return CartItemModel.fromJson(body);
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ??
            'Failed to update cart item quantity',
      );
    }
  }

  @override
  Future<void> deleteCartItem(int id, int userId) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.delete(
      Uri.parse(deleteCartItemEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'userId': userId,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        message: json.decode(response.body)['message'] ??
            'Failed to delete cart item',
      );
    }
  }

  @override
  Future<void> checkoutOrder(int userId) async {
    final token = await SharedPreferencesHelper().getToken();
    final response = await client.post(
      Uri.parse(checkoutOrderEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        message:
            json.decode(response.body)['message'] ?? 'Failed to checkout order',
      );
    }
  }
}
