import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estate Tech Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Our Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ServiceItem(
              icon: Icons.house,
              title: 'Property Management',
              description:
                  'Comprehensive management services for residential and commercial properties.',
            ),
            ServiceItem(
              icon: Icons.business,
              title: 'Real Estate Consulting',
              description:
                  'Expert consulting services for real estate investments and development.',
            ),
            ServiceItem(
              icon: Icons.build,
              title: 'Property Development',
              description:
                  'End-to-end solutions for property development projects.',
            ),
            ServiceItem(
              icon: Icons.analytics,
              title: 'Market Analysis',
              description:
                  'In-depth market analysis to help you make informed investment decisions.',
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  ServiceItem(
      {required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
