import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/core/widgets/popuswidgets/playlistpopup/playlistcureentmore.dart';
import 'package:myapp/pages/homescreen/homewidgets/homesubpages/homesubpagewidgets/homesubpagetitlecard.dart';

class LibPlaylistSubPage extends StatelessWidget {
  const LibPlaylistSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    void _showPlaylistCurrentMorePopupDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return PlaylistCurrentMore();
          });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SubPageTitleCard(
              totalTracks: 10,
              subTitle: 'Playlist Name',
              totalTitle: 'Tracks',
              showIcon: false,
              imagePath: 'https://picsum.photos/250?image=9',
              showText: true,
              Ownertext: 'Abhi',
            ),
            alphaheight10,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ReusablePlaysubBtn(
                          colorScheme: colorScheme,
                          playIcon: Broken.add,
                          playbtnOnPressed: () {},
                        ),
                        ReusablePlaysubBtn(
                          colorScheme: colorScheme,
                          playIcon: Broken.user_add,
                          playbtnOnPressed: () {},
                        ),
                        ReusablePlaysubBtn(
                          colorScheme: colorScheme,
                          playIcon: Broken.send_2,
                          playbtnOnPressed: () {},
                        ),
                        ReusablePlaysubBtn(
                          colorScheme: colorScheme,
                          playIcon: Broken.more,
                          playbtnOnPressed: _showPlaylistCurrentMorePopupDialog
                        ),
                      ],
                    ),
                  ),
                  ReusablePlaysubBtn(
                    colorScheme: colorScheme,
                    playIcon: Broken.play,
                    playbtnOnPressed: () {},
                  ),
                ],
              ),
            ),
            alphaheight20,
            // If playlist have any song show playlistsongs or show Emptyplaylist
            // PlaylistSongs(),     
            EmptyPlaylist(colorScheme: colorScheme),
            alphaheight30,
            RecommendedSongs(colorScheme: colorScheme), 
          ],
        ),
      ),
    );
  }
}

class PlaylistSongs extends StatelessWidget {
  const PlaylistSongs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              'https://picsum.photos/200/300',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alphawidth10,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Song Title',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                            Text(
                              'Artist',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Transform.rotate(
                    angle: 90 * 3.1 / 180,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {},
                      child: Icon(
                        Broken.more,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return alphaheight10;
      },
      itemCount: 5,
    );
  }
}

// RECOMMENED SONGS

class RecommendedSongs extends StatelessWidget {
  const RecommendedSongs({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Icon(Broken.command_square, size: 25, color: colorScheme.primary),
              alphawidth10,
              Expanded(
                child: Text(
                  'Recommended Songs',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'LexendDeca',
                      color: Theme.of(context).primaryColor),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Icon(
                  Broken.refresh_2,
                  size: 23,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 55,
                            height: 55,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                'https://picsum.photos/200/300',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          alphawidth10,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'song name',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'LexendDeca',
                                ),
                              ),
                              Text(
                                'artist',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'LexendDeca',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {},
                      child: Icon(
                        Broken.music_square_add,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return alphaheight10;
          },
          itemCount: 5,
        ),
      ],
    );
  }
}

// EMPTY PLAYLIST

class EmptyPlaylist extends StatelessWidget {
  const EmptyPlaylist({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CURATE YOUR UNIQUE MUSIC SELECTION!',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'LexendDeca',
                color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          alphaheight20,
          Center(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Container(
                width: 280,
                height: 50,
                decoration: BoxDecoration(
                  color: colorScheme.surface.withOpacity(0.66),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: colorScheme.surface,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Broken.add,
                      size: 26,
                      color: colorScheme.primary,
                    ),
                    alphawidth10,
                    Text(
                      'Add Songs To This Playlist',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'LexendDeca',
                          color: Theme.of(context).primaryColor),
                    )
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

// REUSABLEPLAYSUBBTN

class ReusablePlaysubBtn extends StatelessWidget {
  const ReusablePlaysubBtn({
    super.key,
    required this.colorScheme,
    required this.playIcon,
    required this.playbtnOnPressed,
  });

  final IconData playIcon;
  final ColorScheme colorScheme;
  final VoidCallback playbtnOnPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: playbtnOnPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(0.66),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: colorScheme.surface,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
            child: Icon(
              playIcon,
              size: 22,
              color: colorScheme.primary,
            ),
          ),
        ));
  }
}
