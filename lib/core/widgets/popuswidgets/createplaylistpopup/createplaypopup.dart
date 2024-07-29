import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/core/widgets/popuswidgets/createplaylistpopup/createsubpopup.dart';



void showCreatePlaylist(BuildContext context) {
    void _showCreatePlaylistDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CreateSubPopup();
      },
    );
  }
  final colorScheme = Theme.of(context).colorScheme;
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.35,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _showCreatePlaylistDialog,
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Broken.music_playlist,
                                      size: 30,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    alphawidth20,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Playlist',
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'LexendDeca',
                                          ),
                                        ),
                                        Text(
                                          'Create a playlist with your favorite songs',
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'LexendDeca',
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          alphaheight20,
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Icon(
                                    Broken.link_1,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  alphawidth20,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Blend',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'LexendDeca',
                                        ),
                                      ),
                                      
                                      Text(
                                        'Combine tastes in a shared playlist',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'LexendDeca',
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
