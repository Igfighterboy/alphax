import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 40,
          child: TextField(
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'LexendDeca'),
            decoration: InputDecoration(
              hintText: 'What do you want to hear?',
              contentPadding: const EdgeInsets.only(top: 8),
              hintStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'LexendDeca'),
              border: InputBorder.none,
              filled: true,
              fillColor: colorScheme.surface,
              prefixIcon: IconButton(
                icon: Icon(
                  Broken.arrow_left_1,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(13),borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(13),borderSide: BorderSide(color: Colors.transparent)),
            ),
            autofocus: true,
          ),
        ),
      ),
    );
  }
}
