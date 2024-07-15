import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/signscreen/signinscreen/signinscreen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
      body: Stack(
        children: [
          // const SignBackground(),
          Center(
            child: ListView(
              children: const [
                SignUpTitle(),
                alphaheight20,
                SignUpForm(),
                alphaheight20,
                SignUpButton(),
                SizedBox(
                  height: 15,
                ),
                AlreadyhSign(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({
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

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SignUpForm> {
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
              SizedBox(
                width: 350,
                height: 50,
                child: TextFormField(
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

class SignUpButton extends StatelessWidget {
  const SignUpButton({
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Account',
                    style: TextStyle(
                        color: buttontext,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'LexendDeca'),
                  ),
                  alphawidth10,
                  Icon(
                    Broken.login,
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
              boxShadow: const [
                BoxShadow(
                  // color: btnshadow.withOpacity(0.5), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 3), // Offset in the x and y direction
                ),
              ],
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

class AlreadyhSign extends StatelessWidget {
  const AlreadyhSign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(
          const SignInScreen(),
          transition: Transition.cupertino,
          duration: const Duration(
            seconds: 1,
          ),
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
    );
  }
}
