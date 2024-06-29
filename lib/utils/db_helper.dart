import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:store_interface/models/cart.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'cart.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cart(id TEXT PRIMARY KEY, title TEXT, quantity INTEGER, price REAL)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Future<void> saveCart() async {
    _items.forEach((key, value) async {
      await DBHelper.insert('cart', value.toJson());
    });
  }

  Future<void> loadCart() async {
    final dataList = await DBHelper.getData('cart');
    _items = Map.fromIterable(dataList,
        key: (item) => item['id'], value: (item) => CartItem.fromJson(item));
    notifyListeners();
  }
}

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
