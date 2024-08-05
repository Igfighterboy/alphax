import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class PlaylistMorePopUp extends StatelessWidget {
  const PlaylistMorePopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: containerWidth,
          decoration: BoxDecoration(
            color: colorScheme.secondary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.secondary,
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PlaylistMoreTitle(colorScheme: colorScheme),
                alphaheight10,
                const PlaylistDivider(),
                alphaheight10,
                Reusableplaylistbtn(
                  colorScheme: colorScheme,
                  playlistOnTap: () {},
                  playlistBtnIcon: Broken.star_1,
                  playlistBtnLabel: 'Favorite Playlist',
                ),
                alphaheight10,
                Reusableplaylistbtn(
                  colorScheme: colorScheme,
                  playlistOnTap: () {},
                  playlistBtnIcon: Broken.trash,
                  playlistBtnLabel: 'Playlist Delete',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaylistMoreTitle extends StatelessWidget {
  const PlaylistMoreTitle({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    String _truncateText(String text, int limit) {
      if (text.length <= limit) {
        return text;
      } else {
        return '${text.substring(0, limit)}..';
      }
    }

    return Row(
      children: [
        Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: colorScheme.surface.withOpacity(0.66),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colorScheme.surface,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
                fit: BoxFit.cover,
              ),
            )),
        alphawidth10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _truncateText('Playlist Name', 18),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'LexendDeca'),
            ),
            Text(
              'Tracks : 10',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'LexendDeca'),
            ),
          ],
        ),
      ],
    );
  }
}

// PLAYLIST DIVIDER

class PlaylistDivider extends StatelessWidget {
  const PlaylistDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      decoration: BoxDecoration(
        color: dividercolor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

// RESULABLE PLAYLIST BTN

class Reusableplaylistbtn extends StatelessWidget {
  const Reusableplaylistbtn({
    super.key,
    required this.colorScheme,
    required this.playlistOnTap,
    required this.playlistBtnIcon,
    required this.playlistBtnLabel,
  });

  final IconData playlistBtnIcon;
  final String playlistBtnLabel;
  final VoidCallback playlistOnTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: playlistOnTap,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              playlistBtnIcon,
              color: colorScheme.primary,
              size: 23,
            ),
            alphawidth10,
            Text(
              playlistBtnLabel,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'LexendDeca'),
            )
          ],
        ),
      ),
    );
  }
}
