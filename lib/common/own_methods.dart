import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class OwnMethods {
  Future openMail(String email) async {
    String email1 = Uri.encodeComponent(email);
    String subject = Uri.encodeComponent("Subject");
    String body = Uri.encodeComponent("Body");
    print(subject); //output: Hello%20Flutter
    Uri mail = Uri.parse("mailto:$email1?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  String getCurrentDayAndMonth() {
    final now = DateTime.now();
    return '${now.day} ${_getMonthName(now.month)}';
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

  Future<dynamic> getRate(String currenciesType) async {
    var url =
        "https://rest.coinapi.io/v1/exchangerate/$currenciesType/USD?apikey=3B91E1A1-95EF-4F52-81FB-2593337FFF54";

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      /// interprets a given string as JSON
      var decodedData = jsonDecode(response.body);
      var rate = decodedData['rate'];
      return rate;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
