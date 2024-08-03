import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/pages/onboardingscreen/onboardingscreen.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final codeController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(
                  Broken.arrow_left_2,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  alphaheight20,
                  const VerificationTitle(),
                  alphaheight20,
                  VerificationForm(
                    formKey: _formKey,
                    codeController: codeController,
                  ),
                  alphaheight20,
                  VerificationButton(
                    formKey: _formKey,
                    codeController: codeController,
                  ),
                  alphaheight20,
                  const ResendCode(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationTitle extends StatelessWidget {
  const VerificationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        'Email Verification',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).primaryColor,
          fontFamily: 'LexendDeca',
        ),
      ),
    );
  }
}

class VerificationForm extends StatelessWidget {
  const VerificationForm({
    super.key,
    required this.formKey,
    required this.codeController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 50,
              child: TextFormField(
                controller: codeController,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                  labelText: 'Enter 4-digit Code',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'LexendDeca',
                  ),
                  suffixIcon: Icon(
                    Broken.message_text,
                    color: Theme.of(context).primaryColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationButton extends StatelessWidget {
  const VerificationButton({
    super.key,
    required this.formKey,
    required this.codeController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController codeController;

  Future<void> _verifyCode(BuildContext context) async {
    final code = codeController.text;

    if (code.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter the verification code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    Get.dialog(buildLoadingOverlay(), barrierDismissible: false);

    const String url = 'http://172.232.124.96:5056/auth/verify-email';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'code': code,
        }),
      );
      Get.back();

      if (response.statusCode == 200) {
        Get.to(
          () => const OnboardingScreen(),
          transition: Transition.cupertino,
          duration: const Duration(seconds: 1),
        );
      } else {
        final responseData = json.decode(response.body);
        Get.snackbar(
          'Error',
          responseData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      Get.back();
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        children: [
          Center(
            child: Container(
              height: 55,
              width: 350,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextButton(
                onPressed: () => _verifyCode(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Verify',
                      style: TextStyle(
                        color: buttontext,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'LexendDeca',
                      ),
                    ),
                    alphawidth10,
                    Icon(
                      Broken.check,
                      color: buttontext,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResendCode extends StatefulWidget {
  const ResendCode({super.key});

  @override
  _ResendCodeState createState() => _ResendCodeState();
}

class _ResendCodeState extends State<ResendCode> {
  String email = '';

  Future<void> _resendCode(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');

    if (userJson != null) {
      final user = jsonDecode(userJson) as Map<String, dynamic>;
      setState(() {
        email = user['email'] ?? 'user@example.com';
      });
    } else {
      Get.snackbar(
        'Error',
        'Email not found. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    Get.dialog(buildLoadingOverlay(), barrierDismissible: false);

    const String url = 'http://172.232.124.96:5056/auth/resend-code';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );
      Get.back();
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Verification code resent successfully. Please check your email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
      } else {
        final responseData = json.decode(response.body);
        Get.snackbar(
          'Error',
          responseData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      Get.back();
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => _resendCode(context),
        child: Text(
          "Didn't receive the code? Resend",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColor,
            fontFamily: 'LexendDeca',
          ),
        ),
      ),
    );
  }
}

Widget buildLoadingOverlay() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
