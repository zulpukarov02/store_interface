import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: ListView.builder(
                key: ValueKey<int>(cart.items.length),
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartItemWidget(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title,
                ),
              ),
            ),
          ),
          Text('Total: \$${cart.totalAmount}'),
          ElevatedButton(
            onPressed: () {
              // Order logic
            },
            child: Text('Order Now'),
          ),
        ],
      ),
    );
  }
}
