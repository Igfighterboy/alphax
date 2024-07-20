import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  Future<void> sendPostRequest() async {
    final url = Uri.parse('https://172.232.124.96:5108/auth/signup');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'password': 'password123'
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Data received: ${response.body}');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: sendPostRequest,
      child: Text('Send POST Request'),
    );
  }
}