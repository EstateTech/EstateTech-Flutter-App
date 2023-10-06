import 'package:url_launcher/url_launcher.dart';

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
}
