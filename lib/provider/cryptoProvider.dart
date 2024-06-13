import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoProvider with ChangeNotifier {
  List<dynamic> _coins = [];
  double _ethPrice = 0.0;

  List<dynamic> get coins => _coins;
  double get ethPrice => _ethPrice;

  Future<void> fetchCoinMarkets() async {
    final url = Uri.parse('https://api.coingecko.com/api/v3/coins/markets');
    final headers = {
      'accept': 'application/json',
      'x-cg-pro-api-key': 'CG-dVDAkHdtPbNcborGN3qDrC1R'
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        _coins = json.decode(response.body);
        notifyListeners();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('error: $error');
    }
  }

  Future<void> fetchEthPrice() async {
    final url = Uri.parse(
        'https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd');
    final headers = {
      'accept': 'application/json',
      'x-cg-pro-api-key': 'CG-dVDAkHdtPbNcborGN3qDrC1R'
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _ethPrice = jsonResponse['ethereum']['usd'].toDouble();
        notifyListeners();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('error: $error');
    }
  }
}
