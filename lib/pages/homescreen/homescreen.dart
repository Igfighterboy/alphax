import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold( 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              HomeUserTitle(colorScheme: colorScheme),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeUserTitle extends StatelessWidget {
  const HomeUserTitle({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hey ,',style: TextStyle(
          fontFamily: 'LexendDeca',
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColor,
        ),),
        Text('UserName',style: TextStyle(
          fontFamily: 'LexendDeca',
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: colorScheme.primary,
        ),),
      ],
    );
  }
}




// Center(
//         child: ElevatedButton(
//           onPressed: () {
//           Navigator.of(context).push(
//             CupertinoPageRoute(builder: (context) => TestingPage()),
//           );
//         },
//           child: Text('Go to Home Detail'),
//         ),
//       ),