import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/pages/signscreen/signinscreen/signinscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         const SafeArea(
              child: Center(
            child: MainArea(),
          ))
        ],
      ),
    );
  }
}

class MainArea extends StatelessWidget {
  const MainArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(
            //   color: secondarycolor, // Customize border color
            //   width: 1.0, // Customize border width
            // ),
            boxShadow: [
              BoxShadow(
                // color:
                //     secondarycolor.withOpacity(0.1), // Customize shadow color
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // Customize shadow offset
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/logo.png',
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // sheight2,
        // SplashScreen(),
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(10),
        //   child: const SizedBox(
        //     width: 100,
        //     height: 6,
        //     child: LinearProgressIndicator(
        //       // backgroundColor: textcolor,
        //       // valueColor: AlwaysStoppedAnimation<Color>(primarycolor),
        //     ),
        //   ),
        // ),
        const Spacer(
          flex: 1,
        ),
        Column(
          children: [
            Text(
              'From',
              // style: GoogleFonts.poppins(
              //   color: textcolor,
              //   fontSize: 15,
              //   fontWeight: FontWeight.w400,
              // ),
            ),
            Text(
              'ELiTE DEVS',
              // style: GoogleFonts.firaSans(
              //   color: textcolor,
              //   fontSize: 20,
              //   fontWeight: FontWeight.w600,
              // ),
            )
          ],
        ),
        const Spacer()
      ],
    );
  }
}