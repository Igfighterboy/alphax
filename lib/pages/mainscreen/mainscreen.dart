import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/homescreen/homescreen.dart';
import 'package:myapp/pages/libraryscreen/libraryscreen.dart';
import 'package:myapp/pages/mainscreen/widget/drawerwidget.dart';
import 'package:myapp/pages/playerscreen/fullplayer.dart';
import 'package:myapp/pages/playerscreen/player.dart';
import 'package:myapp/pages/profilescreen/profilescreen.dart';
import 'package:myapp/pages/searchscreen/searchscreen.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import '../../controller/playercontroller/playerstate.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime? lastPressed;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  int _selectedIndex = 0;
  String _currentRoute = '/home';

  bool _showBottomNavBar = true;
  bool _showAppBar = true;
  bool _isFullScreenPlayerVisible = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showBottomNavBar = true;
      _showAppBar = true;
      String newRoute;
      switch (_selectedIndex) {
        case 0:
          newRoute = '/home';
          break;
        case 1:
          newRoute = '/search';
          break;
        case 2:
          newRoute = '/library';
          break;
        case 3:
          newRoute = '/profile';
          break;
        default:
          newRoute = '/home';
      }
      if (_currentRoute != newRoute) {
        _currentRoute = newRoute;
        _navigatorKey.currentState!.pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => _getPage(newRoute)),
          (route) => false,
        );
      } else if (_currentRoute == '/home') {
        _navigatorKey.currentState!.popUntil((route) => route.isFirst);
      }
    });
  }

  void _navigateTo(String routeName) {
    setState(() {
      if (_currentRoute != routeName) {
        _currentRoute = routeName;
        _navigatorKey.currentState!.push(
          CupertinoPageRoute(builder: (context) => _getPage(routeName)),
        );
      }
    });
  }

  Widget _getPage(String routeName) {
    switch (routeName) {
      case '/home':
        return HomeScreen();
      case '/search':
        return SearchScreen();
      case '/library':
        return const LibraryScreen();
      case '/profile':
        return const ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  Future<bool> _onWillPop() async {
    if (_isFullScreenPlayerVisible) {
      _hideFullScreenPlayer();
      return Future.value(false);
    }

    if (_navigatorKey.currentState!.canPop()) {
      _navigatorKey.currentState!.pop();
      return Future.value(false);
    }

    final now = DateTime.now();
    final maxDuration = Duration(seconds: 2);
    final isWarning =
        lastPressed == null || now.difference(lastPressed!) > maxDuration;

    if (isWarning) {
      lastPressed = DateTime.now();
      final snackBar = SnackBar(content: Text('Press once more to exit'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  final advanceddrawerController = AdvancedDrawerController();

  void _showFullScreenPlayer() {
    setState(() {
      _isFullScreenPlayerVisible = true;
      _showAppBar = false;
      _showBottomNavBar = false;
    });
  }

  void _hideFullScreenPlayer() {
    setState(() {
      _isFullScreenPlayerVisible = false;
      _showAppBar = true;
      _showBottomNavBar = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AdvancedDrawer(
      backdropColor: colorScheme.secondary,
      controller: advanceddrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      animateChildDecoration: true,
      openScale: 1,
      openRatio: 0.59,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      rtlOpening: false,
      drawer: DrawerWidget(
        navigatorKey: _navigatorKey,
        advanceddrawerController: advanceddrawerController,
      ),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: _showAppBar
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(50.0),
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    flexibleSpace: Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                drawerControl();
                              },
                              child: Icon(
                                Broken.menu,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                                  width: 35,
                                  height: 35,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : null,
          body: Stack(
            children: [
              Navigator(
                key: _navigatorKey,
                initialRoute: '/home',
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/home':
                      builder = (BuildContext _) => HomeScreen();
                      break;
                    case '/search':
                      builder = (BuildContext _) => SearchScreen();
                      break;
                    case '/library':
                      builder = (BuildContext _) => const LibraryScreen();
                      break;
                    case '/profile':
                      builder = (BuildContext _) => const ProfileScreen();
                      break;
                    default:
                      builder = (BuildContext _) => HomeScreen();
                  }
                  return CupertinoPageRoute(
                      builder: builder, settings: settings);
                },
              ),
              Consumer<PlayerState>(
                builder: (context, playerState, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: playerState.isMiniPlayerVisible ||
                            _isFullScreenPlayerVisible
                        ? _isFullScreenPlayerVisible
                            ? FullScreenPlayer(
                                onCollapse: _hideFullScreenPlayer)
                              : Align(
                                alignment: Alignment.bottomCenter,
                                child:
                                    MiniPlayer(onExpand: _showFullScreenPlayer),
                              )
                      : const SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: _showBottomNavBar
              ? NavigationBar(
                  animationDuration: const Duration(seconds: 1),
                  height: 64.0,
                  elevation: 22,
                  labelBehavior:
                      NavigationDestinationLabelBehavior.onlyShowSelected,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemTapped,
                  destinations: [
                    NavigationDestination(
                      icon: Icon(
                        Broken.home_1,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: 'Home',
                      selectedIcon: Icon(
                        Broken.home_1,
                        color: iconscolor,
                      ),
                    ),
                    NavigationDestination(
                      icon: Icon(
                        Broken.search_normal,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: 'Search',
                      selectedIcon: Icon(
                        Broken.search_normal,
                        color: iconscolor,
                      ),
                    ),
                    NavigationDestination(
                      icon: Icon(
                        Broken.music_library_2,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: 'Library',
                      selectedIcon: Icon(
                        Broken.music_library_2,
                        color: iconscolor,
                      ),
                    ),
                    NavigationDestination(
                      icon: Icon(
                        Broken.profile_2user,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: 'Profile',
                      selectedIcon: Icon(
                        Broken.profile_2user,
                        color: iconscolor,
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  void drawerControl() {
    advanceddrawerController.showDrawer();
  }
}

