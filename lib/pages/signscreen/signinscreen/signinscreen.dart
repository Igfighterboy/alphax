import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/signscreen/signupscreen/signupscreen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
      body: const Stack(
        children: [
          // SignBackground(),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  alphaheight20,
                  SigninTitle(),
                  alphaheight20,
                  SigninForm(),
                  alphaheight20,
                  SignButton(),
                  alphaheight20,
                  AlreadySign(),
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
  const SigninForm({
    super.key,
  });

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                width: 350,
                height: 50,
                child: TextFormField(
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
                        borderRadius: BorderRadius.circular(40)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(40)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),

              alphaheight20,
              // PASSWORD
              SizedBox(
                width: 350,
                height: 50,
                child: TextFormField(
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
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

class SignButton extends StatelessWidget {
  const SignButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
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
              onPressed: null,
              // onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ScreenAll(),
              //     ),
              //   );
              // },
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
    );
  }
}

class AlreadySign extends StatelessWidget {
  const AlreadySign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(
          SignUpScreen(),
          transition: Transition.cupertino,
          duration: Duration(
            seconds: 1,
          ),
        );
      },
      child: Text(
        "Don't Have A Account? Sign Up",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColor,
          fontFamily: 'LexendDeca',
        ),
      ),
    );
  }
}
