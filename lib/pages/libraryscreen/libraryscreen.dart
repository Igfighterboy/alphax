import 'package:flutter/material.dart';
import 'package:myapp/controller/librarycontroller/librarycontroller.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/libraryscreen/librarywidgets/animatedserachbar.dart';
import 'package:myapp/pages/libraryscreen/librarywidgets/libraryplaylistcards/libplaylistgrid.dart';
import 'package:myapp/pages/libraryscreen/librarywidgets/libraryplaylistcards/libplaylistlist.dart';
import 'package:myapp/pages/libraryscreen/librarywidgets/librarystatscsrd.dart';
import 'package:myapp/core/widgets/popuswidgets/createplaylistpopup/createplaypopup.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final ValueNotifier<bool> _isGridViewNotifier = ValueNotifier(false);

  final List<Widget> _libraryStats = [
    const LibraryStatsCard(
      alphamaintitle: 'Playlist',
      alphamaincount: '8',
      alphamainIcon: Broken.music_playlist,
      alphamaincolor: Colors.blue,
    ),
    const LibraryStatsCard(
      alphamaintitle: 'Artist',
      alphamaincount: '8',
      alphamainIcon: Broken.profile_2user,
      alphamaincolor: Colors.green,
    ),
    const LibraryStatsCard(
      alphamaintitle: 'Favourites',
      alphamaincount: '8',
      alphamainIcon: Broken.heart,
      alphamaincolor: Colors.red,
    ),
    const LibraryStatsCard(
      alphamaintitle: 'Blended',
      alphamaincount: '8',
      alphamainIcon: Broken.link_1,
      alphamaincolor: Colors.purple,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadViewType();
  }

  Future<void> _loadViewType() async {
    bool isGridView = await PreferenceService.getViewType();
    _isGridViewNotifier.value = isGridView;
  }

  Future<void> _toggleViewType() async {
    _isGridViewNotifier.value = !_isGridViewNotifier.value;
    await PreferenceService.setViewType(_isGridViewNotifier.value);
  }

 

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(slivers: [
            SliverAppBar(
              title: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const AnimatedSearch(),
                        alphawidth10,
                        GestureDetector(
                          onTap: null,
                          child: Icon(
                            Broken.filter,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showCreatePlaylist(context),
                    child: Icon(
                      Broken.add,
                      size: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  alphawidth10,
                  ValueListenableBuilder<bool>(
                    valueListenable: _isGridViewNotifier,
                    builder: (context, isGridView, child) {
                      return GestureDetector(
                        onTap: _toggleViewType,
                        child: Icon(
                          isGridView ? Broken.grid_2 : Broken.grid_1,
                          size: 25,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
              snap: true,
              floating: true,
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                key: const ValueKey('grid'),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _libraryStats.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2 / 0.35,
                ),
                itemBuilder: (context, index) {
                  return _libraryStats[index];
                },
              ),
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isGridViewNotifier,
                  builder: (context, isGridView, child) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: isGridView
                          ? const LibraryplaylistGrid()
                          : const LibraryplaylistList(),
                    );
                  },
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
