import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../home.dart';

class DetailObat extends StatelessWidget {
  final Drug drug;

  const DetailObat({Key? key, required this.drug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    final formattedPrice = _formatPrice(drug.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Obat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              drug.image,
              height: 250,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    drug.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    drug.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  _buildDrugInfo('Dose', drug.dose),
                  _buildDrugInfo('Class', drug.drugClass),
                  _buildDrugInfo('Factory', drug.drugFactory),
                  _buildDrugInfo('Type', drug.drugType),
                  _buildDrugInfo('Packaging', drug.packaging),
                  const SizedBox(height: 16),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  _buildPriceInfo('Price', formattedPrice, Colors.red),
                  _buildPriceInfo('Stock', '${drug.stock}', Colors.green),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final userId =
                          await SharedPreferencesHelper().getUserId();
                      if (userId != null) {
                        context.read<CartBloc>().add(AddItemToCartEvent(
                              userId: userId,
                              drugId: drug.id,
                              quantity: 1,
                            ));
                      } else {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme
                          .primary, // blue color for button add to cart
                      foregroundColor: colorScheme
                          .onPrimary, // white color for text add to cart

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]}.')}';
  }

  Widget _buildDrugInfo(String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            info,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(String title, String info, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
