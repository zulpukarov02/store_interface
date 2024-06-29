import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: <Widget>[
          Hero(
            tag: product.id,
            child: Image.network(
              product.imageUrl,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Text(
                    'Image not found'); // Placeholder or error message
              },
            ),
          ),
          Text(product.title),
          Text('\$${product.price}'),
          Text(product.description),
          ElevatedButton(
            onPressed: () {
              // Add to cart logic
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
