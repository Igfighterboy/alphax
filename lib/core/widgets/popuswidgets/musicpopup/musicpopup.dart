import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class MusicPopup extends StatelessWidget {
  final String currenttitle;
  final String currentartist;
  final String currentthumbnail;

  final VoidCallback onAddToLikedSongs;
  final VoidCallback onAddToPlaylist;
  final VoidCallback onAddToQueue;
  final VoidCallback onGoToAlbum;
  final VoidCallback onShare;
  final VoidCallback onGoToArtist;

  const MusicPopup({
    super.key,
    required this.currenttitle,
    required this.currentartist,
    required this.currentthumbnail,
    required this.onAddToLikedSongs,
    required this.onAddToPlaylist,
    required this.onAddToQueue,
    required this.onGoToAlbum,
    required this.onShare,
    required this.onGoToArtist,
  });

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
            color: colorScheme.surface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.surface,
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMusicTitle(
                  colorScheme: colorScheme,
                  currenttitle: currenttitle,
                  currentartist: currentartist,
                  currentthumbnail: currentthumbnail,
                ),
                alphaheight20,
                const CustomDivider(),
                alphaheight20,
                ResuableButton(
                  colorScheme: colorScheme,
                  label: 'Add To Liked Songs',
                  icon: Broken.heart,
                  onTap: onAddToLikedSongs,
                ),
                alphaheight10,
                ResuableButton(
                  colorScheme: colorScheme,
                  label: 'Add To Playlist',
                  icon: Broken.music_playlist,
                  onTap: onAddToPlaylist,
                ),
                alphaheight10,
                ResuableButton(
                  colorScheme: colorScheme,
                  label: 'Add To Queue',
                  icon: Broken.music_square_add,
                  onTap: onAddToQueue,
                ),
                alphaheight10,
                ResuableButton(
                  colorScheme: colorScheme,
                  label: 'Go To Album',
                  icon: Broken.creative_commons,
                  onTap: onGoToAlbum,
                ),
                alphaheight10,
                ResuableButton(
                  colorScheme: colorScheme,
                  label: 'Share',
                  icon: Broken.send_2,
                  onTap: onShare,
                ),
                alphaheight10,
                ResuableButton(
                  colorScheme: colorScheme,
                  label: 'Go To Artist',
                  icon: Broken.microphone,
                  onTap: onGoToArtist,
                ),
                alphaheight10,
                const CustomDivider(),
                alphaheight10,
                PopUpPlayButton(colorScheme: colorScheme),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// SONG TITLE

class PopupMusicTitle extends StatelessWidget {
  final String currenttitle;
  final String currentartist;
  final String currentthumbnail;
  const PopupMusicTitle({
    super.key,
    required this.colorScheme,
    required this.currenttitle,
    required this.currentartist,
    required this.currentthumbnail,
  });

  final ColorScheme colorScheme;
  String _truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return '${text.substring(0, limit)}..';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                currentthumbnail,
                fit: BoxFit.cover,
              ),
            )),
        alphawidth10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _truncateText(currenttitle, 15),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'LexendDeca'),
            ),
            Text(
              _truncateText(currentartist, 17),
              style: TextStyle(
                  fontSize: 15,
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

// DIVIDER

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

// RESUABLE BUTTON

class ResuableButton extends StatelessWidget {
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final String label;
  final IconData icon;

  const ResuableButton({
    super.key,
    required this.colorScheme,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              icon,
              color: colorScheme.primary,
              size: 28,
            ),
            alphawidth10,
            Text(
              label,
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'LexendDeca'),
            )
          ],
        ),
      ),
    );
  }
}

//  PLAY BUTTON

class PopUpPlayButton extends StatelessWidget {
  const PopUpPlayButton({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Play',
                style: TextStyle(
                    fontSize: 18,
                    color: iconscolor,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'LexendDeca'),
              ),
              alphawidth10,
              Icon(
                Broken.play,
                color: iconscolor,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
