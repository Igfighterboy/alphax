import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/accountscreation/accountcreation.dart';
import 'package:myapp/pages/mainscreen/mainscreen.dart';
import 'package:myapp/pages/onboardingscreen/onboardingscreen.dart';
import 'package:myapp/pages/signscreen/signinscreen/signinscreen.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/pages/signscreen/signupscreen/verifyemail.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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
                onPressed: null,
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
          // SignBackground(),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  alphaheight20,
                  const SigninTitle(),
                  alphaheight20,
                  SigninForm(
                    formKey: _formKey,
                    usernameController: usernameController,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  alphaheight20,
                  SignButton(
                    formKey: _formKey,
                    usernameController: usernameController,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  alphaheight20,
                  const AlreadySign(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SigninTitle extends StatelessWidget {
  const SigninTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        'Sign Up',
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

class SigninForm extends StatefulWidget {
  const SigninForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 50,
              child: TextFormField(
                controller: widget.usernameController,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'LexendDeca',
                  ),
                  suffixIcon: Icon(
                    Broken.people,
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
            alphaheight20,
            SizedBox(
              width: 350,
              height: 50,
              child: TextFormField(
                controller: widget.emailController,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                  labelText: 'Email',
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
            alphaheight20,
            SizedBox(
              width: 350,
              height: 50,
              child: TextFormField(
                controller: widget.passwordController,
                style: TextStyle(color: Theme.of(context).primaryColor),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIcon: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: Icon(
                        _obscureText ? Broken.eye_slash : Broken.eye,
                        key: ValueKey<bool>(_obscureText),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
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

class SignButton extends StatelessWidget {
  const SignButton({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  Future<void> _signup(BuildContext context) async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill out all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    Get.dialog(buildLoadingOverlay(), barrierDismissible: false);

    const String url = 'http://172.232.124.96:5056/auth/signup';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      // Close the loading dialog
      Get.back();

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final String token = responseData['token'];
        final user = responseData['user'];
        final userJson = jsonEncode(user);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userToken', token);
        await prefs.setString('user', userJson);

        Get.to(
          () => const EmailVerificationScreen(),
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
      print(error);
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
                onPressed: () => _signup(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: buttontext,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'LexendDeca',
                      ),
                    ),
                    alphawidth10,
                    Icon(
                      Broken.login_1,
                      color: buttontext,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
          alphaheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Divider(
                  color: dividercolor,
                  thickness: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'LexendDeca',
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: Divider(
                  color: dividercolor,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          alphaheight20,
          Center(
            child: Container(
              height: 55,
              width: 350,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue With ',
                      style: TextStyle(
                        color: buttontext,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'LexendDeca',
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/google.svg',
                      height: 30,
                      color: buttontext,
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

class AlreadySign extends StatelessWidget {
  const AlreadySign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Get.to(
            () => const SignInScreen(),
            transition: Transition.cupertino,
            duration: const Duration(seconds: 1),
          );
        },
        child: Text(
          "Already Have A Account? Sign In",
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
