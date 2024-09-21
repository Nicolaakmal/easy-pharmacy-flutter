import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/core.dart';
import '../data.dart';

abstract class ApiServicesDrug {
  Future<List<DrugModel>> getDrugs(int page, int size,
      {String? search, bool? inStock, String? sortBy});
}

class ApiServicesDrugImpl implements ApiServicesDrug {
  final http.Client client;

  ApiServicesDrugImpl(this.client);

  @override
  Future<List<DrugModel>> getDrugs(int page, int size,
      {String? search, bool? inStock, String? sortBy}) async {
    final queryParameters = {
      'page[size]': size.toString(),
      'page[number]': page.toString(),
      if (search != null && search.isNotEmpty) 'search': search,
      // if (inStock != null) 'inStock': inStock.toString(),
      // if (sortBy != null) 'sortBy': sortBy,
    };

    final uri =
        Uri.parse(drugListEndpoint).replace(queryParameters: queryParameters);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body)['data'];
      return body.map((json) => DrugModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message:
              json.decode(response.body)['message'] ?? 'Failed to load drugs');
    }
  }
}
