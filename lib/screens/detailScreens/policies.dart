import 'package:flutter/material.dart';

class PoliciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estate Tech Policies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Our Policies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            PolicyItem(
              title: 'Privacy Policy',
              description:
                  'We value your privacy and ensure your data is protected in accordance with industry standards.',
            ),
            PolicyItem(
              title: 'Return Policy',
              description:
                  'Our return policy allows for returns within 30 days of purchase, subject to terms and conditions.',
            ),
            PolicyItem(
              title: 'Shipping Policy',
              description:
                  'We provide reliable and timely shipping services for all our properties and related documents.',
            ),
            PolicyItem(
              title: 'Terms of Service',
              description:
                  'By using our services, you agree to comply with our terms and conditions as outlined here.',
            ),
          ],
        ),
      ),
    );
  }
}

class PolicyItem extends StatelessWidget {
  final String title;
  final String description;

  PolicyItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
