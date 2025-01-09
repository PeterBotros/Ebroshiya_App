import 'package:flutter/material.dart';

class YearPage extends StatelessWidget {
  final int year;

  const YearPage({Key? key, required this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Year $year'),
      ),
      body: Center(
        child: Text(
          'Welcome to the year $year!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
