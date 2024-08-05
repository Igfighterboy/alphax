import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/mainscreen/mainscreen.dart';
import 'package:myapp/pages/signscreen/signupscreen/signupscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<_SigninFormState> _formKey = GlobalKey<_SigninFormState>();
  bool _isLoading = false;

  void _toggleLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                 Get.to(
            () => MainScreen(),
            transition: Transition.cupertino,
            duration: const Duration(seconds: 1),
          );
                },
                child: Icon(
                  Broken.arrow_left_2,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
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
                  SigninTitle(),
                  alphaheight20,
                  SigninForm(
                    key: _formKey,
                    onSignIn: () async {
                      _toggleLoading(true);
                      await _formKey.currentState?._signIn();
                      _toggleLoading(false);
                    },
                  ),
                  alphaheight20,
                  SignButton(
                    onSignIn: () {
                      if (_formKey.currentState != null) {
                        _formKey.currentState!._signIn();
                      }
                    },
                  ),
                  alphaheight20,
                  AlreadySign(),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SigninTitle extends StatelessWidget {
  const SigninTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        'Sign In',
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
  final Future<void> Function() onSignIn;

  SigninForm({Key? key, required this.onSignIn}) : super(key: key);

  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;
      const String url = 'http://172.232.124.96:5056/auth/login';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          Get.snackbar(
            'Success',
            'Successfully signed in!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          final String token = responseData['token'];
          final user = responseData['user'];
          final userJson = jsonEncode(user);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userToken', token);
          await prefs.setString('user', userJson);
            Get.to(
              () => MainScreen(),
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
            colorText: Colors.white,
          );
        }
      } catch (e) {
        print(e);
        Get.snackbar(
          'Error',
          'An unexpected error occurred.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey, // Attach the form key
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 50,
              child: TextFormField(
                controller: _emailController,
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
                      borderRadius: BorderRadius.circular(40)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(40)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
            alphaheight20,
            SizedBox(
              width: 350,
              height: 50,
              child: TextFormField(
                controller: _passwordController,
                style: TextStyle(color: Theme.of(context).primaryColor),
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 23,
                      fontWeight: FontWeight.w400),
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
                      borderRadius: BorderRadius.circular(40)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(40)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignButton extends StatelessWidget {
  final VoidCallback onSignIn;

  const SignButton({Key? key, required this.onSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Container(
              height: 55,
              width: 350,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextButton(
                onPressed: () {
                  onSignIn(); // Use the callback function here
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                          color: buttontext,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'LexendDeca'),
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
                width: 100, // Set the desired width here
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
                      fontFamily: 'LexendDeca'),
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
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextButton(
                onPressed: null, // Add functionality as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue With ',
                      style: TextStyle(
                          color: buttontext,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'LexendDeca'),
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
  const AlreadySign({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Get.to(
            () => SignUpScreen(),
            transition: Transition.cupertino,
            duration: const Duration(seconds: 1),
          );
        },
        child: Text(
          "Don't Have An Account? Sign Up",
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
