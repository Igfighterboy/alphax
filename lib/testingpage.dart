import 'package:flutter/material.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true; // Prevent default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Testing Page'),
        ),
        body: Center(
          child: Text('Testing Page Content'),
        ),
      ),
    );
  }
}
