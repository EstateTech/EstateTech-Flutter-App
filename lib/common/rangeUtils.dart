import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  static String getFormatttedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));

    return TimeOfDay.fromDateTime(date).format(context);
  }

 static String convertCurrency(String amount, String currency, double eth,
      double btc, double guds, double usdc, double usdt) {
    // Define the exchange rate between USD and AED
    double exchangeRate = 3.67; // Replace with the actual exchange rate
    double? amountValue = double.tryParse(amount);

    if (amountValue == null) {
      return "Invalid amount: $amount";
    }

    print("Amount: $amount");
    print("Currency: $currency");
    print("Parsed Amount Value: $amountValue");

    if (currency == "USD") {
      // Convert USD to AED
      double result = amountValue * exchangeRate;
      print("Conversion Result: $result AED");
      return result.toStringAsFixed(2) + " AED";
    } else if (currency == "AED") {
      // Convert AED to USD
      double result = amountValue / exchangeRate;
      print("Conversion Result: $result USD");
      return result.toStringAsFixed(2) + " USD";
    } else if (currency == 'Eth') {
      double result = amountValue / eth;
      print("Conversion Result: $result Eth");
      return result.toStringAsFixed(6) + " Eth";
    } else if (currency == 'Btc') {
      double result = amountValue / btc;
      print("Conversion Result: $result Btc");
      return result.toStringAsFixed(8) + " Btc";
    } else if (currency == 'Guds') {
      double result = amountValue / guds;
      print("Conversion Result: $result Guds");
      return result.toStringAsFixed(2) + " Guds";
    } else if (currency == 'Usdc') {
      double result = amountValue / usdc;
      print("Conversion Result: $result Usdc");
      return result.toStringAsFixed(2) + " Usdc";
    } else if (currency == 'Usdt') {
      double result = amountValue / usdt;
      print("Conversion Result: $result Usdt");
      return result.toStringAsFixed(2) + " Usdt";
    } else {
      return "Unsupported currency: $currency";
    }
  }


  static String getFirstThreeWords(String sentence) {
    // Split the sentence into individual words
    List<String> words = sentence.split(' ');

    // Take the first three words or less if the sentence has fewer than three words
    List<String> firstThreeWords = words.take(3).toList();

    // Join the words back into a sentence
    String result = firstThreeWords.join(' ');

    return result;
  }

  static String joinWithComma(List<String> strings) {
    String result = strings.join(', ');
    return result;
  }

  static String formatLargeNumber(int number) {
    if (number >= 1000000) {
      // Format as millions (e.g., 1.1M for 1,100,000)
      final formattedNumber = number / 1000000;
      final format = NumberFormat("0.0M");
      return format.format(formattedNumber) + "";
    } else if (number >= 1000) {
      // Format as thousands (e.g., 1.1K for 1,100)
      final formattedNumber = number / 1000;
      final format = NumberFormat("0.0K");
      return format.format(formattedNumber) + "";
    } else {
      // Format as is (e.g., 999)
      final format = NumberFormat.decimalPattern();
      return format.format(number);
    }
  }
}
