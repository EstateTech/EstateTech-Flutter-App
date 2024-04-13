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

  static String convertCurrency(
      String amount, String currency, double eth, double btc) {
    // Define the exchange rate between USD and AED
    double exchangeRate = 3.67; // Replace with the actual exchange rate
    double amountValue = double.tryParse(amount) ?? 0.0;

    if (currency == "USD") {
      // Convert USD to AED

      return amount.toString() + " USDT";
    } else if (currency == "AED") {
      // Convert AED to USD
      double result = amountValue * exchangeRate;
      int roundedResult = result.toInt();
      //  return formatLargeNumber(roundedResult);
      return roundedResult.toString() + " AED";
    } else if (currency == 'Eth') {
      double result = amountValue / eth;
      int roundedResult = result.toInt();
      return roundedResult.toStringAsFixed(2) + " Eth";
    } else if (currency == 'Btc') {
      double result = amountValue / btc;
      // int roundedResult = result.toInt();
      return result.toStringAsFixed(2) + " Btc";
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
