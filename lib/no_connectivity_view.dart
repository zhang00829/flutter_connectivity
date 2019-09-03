import 'package:flutter/material.dart';

class NoConnectivityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Opps'),),
      body: Center(
        child: Text('Opps'),
      ),
    );
  }
}
