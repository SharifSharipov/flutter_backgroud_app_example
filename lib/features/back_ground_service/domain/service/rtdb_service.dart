
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/data/models/currency_price.dart';

class RTDBService {
  static final DatabaseReference _database = FirebaseDatabase.instance.ref();
  static const String _currencyPricesPath = 'CurrencyPrices';

  static Future<void> createData({required CurrencyPrice currencyPrice}) async {
    try {
      await _database.child(_currencyPricesPath).push().set(currencyPrice.toJson());
      print("CurrencyPrice stored successfully.");
    } catch (e) {
      print("Error storing CurrencyPrice: $e");
    }
  }//vaqt bn lat long

  static Future<Map<String, CurrencyPrice>?> readData() async {
    try {
      DataSnapshot snapshot = await _database.child(_currencyPricesPath).get();
      Map<String, CurrencyPrice> currencyPrices = {};

      if (snapshot.exists) {
        snapshot.children.forEach((child) {
          var myJson = jsonEncode(child.value);
          Map<String, dynamic> map = jsonDecode(myJson);
          currencyPrices[child.key.toString()] = CurrencyPrice.fromJson(map);
        });
      }

      return currencyPrices;
    } catch (e) {
      print("Error reading CurrencyPrices: $e");
      return null;
    }
  }

  static Future<void> updateData(CurrencyPrice currencyPrice, String currencyPriceKey) async {
    try {
      await _database.child(_currencyPricesPath).child(currencyPriceKey).update(currencyPrice.toJson());
      print('CurrencyPrice updated successfully.');
    } catch (e) {
      print("Error updating CurrencyPrice: $e");
    }
  }

  static Future<void> deleteData(String currencyPriceId) async {
    try {
      await _database.child(_currencyPricesPath).child(currencyPriceId).remove();
      print('CurrencyPrice deleted successfully.');
    } catch (e) {
      print("Error deleting CurrencyPrice: $e");
    }
  }
}
