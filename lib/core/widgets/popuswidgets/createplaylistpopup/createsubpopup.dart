import 'package:flutter/material.dart';

class CreateSubPopup extends StatelessWidget {
  const CreateSubPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: colorScheme.surface,
      title: Text(
        'Create New Playlist',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'LexendDeca',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
            child: TextField(
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'LexendDeca',
              ),
              decoration: InputDecoration(
                hintText: 'Playlist Name',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12), // Adjusted padding
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'LexendDeca',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.0,
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.0,
                  ),
                ),
              ),
              autofocus: true,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: colorScheme.primary,
              fontFamily: 'LexendDeca',
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Save',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: colorScheme.primary,
              fontFamily: 'LexendDeca',
            ),
          ),
        ),
      ],
    );
  }
}
