import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _searchQuery = '';
  String? _selectedCategory;
  double _maxPrice = 1000;

  final List<Product> products = [
    Product(
      id: 'p1',
      title: 'Product 1',
      description: 'Description of Product 1',
      price: 29.99,
      imageUrl: 'https://i.ibb.co/TYd0V6J/image-t-Di.webp',
      category: 'Category 1',
    ),
    Product(
      id: 'p2',
      title: 'Product 2',
      description: 'Description of Product 2',
      price: 49.99,
      imageUrl: 'https://i.ibb.co/H7XwmS3/image-VZX-1.png',
      category: 'Category 2',
    ),
    // Add more products here
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return product.title.toLowerCase().contains(_searchQuery.toLowerCase()) &&
          (_selectedCategory == null ||
              product.category == _selectedCategory) &&
          product.price <= _maxPrice;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight * 2),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      hint: const Text('Category'),
                      value: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: null,
                          child: Text('All'),
                        ),
                        DropdownMenuItem(
                          child: Text('Category 1'),
                          value: 'Category 1',
                        ),
                        DropdownMenuItem(
                          child: Text('Category 2'),
                          value: 'Category 2',
                        ),
                        // Add more categories here
                      ],
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 1000,
                        divisions: 20,
                        label: _maxPrice.toString(),
                        value: _maxPrice,
                        onChanged: (value) {
                          setState(() {
                            _maxPrice = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (ctx, i) => ListTile(
          leading: Image.network(filteredProducts[i].imageUrl),
          title: Text(filteredProducts[i].title),
          subtitle: Text('\$${filteredProducts[i].price}'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(filteredProducts[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}
