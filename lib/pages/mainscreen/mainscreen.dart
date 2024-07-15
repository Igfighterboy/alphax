import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/constatnts/colors.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/homescreen/homescreen.dart';
import 'package:myapp/pages/libraryscreen/libraryscreen.dart';
import 'package:myapp/pages/profilescreen/profilescreen.dart';
import 'package:myapp/pages/searchscreen/searchscreen.dart';
import 'package:myapp/testingpage.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;
//   int _previousIndex = 0;
//   final PageController _pageController = PageController();
//   final List<Widget> _pages = <Widget>[
// const HomeScreen(),
// const SearchScreen(),
// const LibraryScreen(),
// const ProfileScreen(),
// const TestingPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _previousIndex = _selectedIndex;
//       _selectedIndex = index;
//     });
//     _pageController.animateToPage(index,
//         duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: PageTransitionSwitcher(
//           duration: const Duration(milliseconds: 300),
//           reverse: _previousIndex < _selectedIndex,
//           transitionBuilder: (child, animation, secondaryAnimation) {
//             return CupertinoPageTransition(
//               primaryRouteAnimation: animation,
//               secondaryRouteAnimation: secondaryAnimation,
//               linearTransition: true,
//               child: child,
//             );
//           },
//           child: _pages[_selectedIndex],
//         ),
//   bottomNavigationBar: NavigationBarTheme(
// data: NavigationBarThemeData(
// backgroundColor: Theme.of(context).scaffoldBackgroundColor,
// indicatorColor: bothtabbackgroundcolor,
// labelTextStyle: WidgetStatePropertyAll(
//   TextStyle(
//     overflow: TextOverflow.ellipsis,
//     fontSize: 13.0,
//     fontWeight: FontWeight.w400,
//     color: Theme.of(context).primaryColor,
//     fontFamily: 'LexendDeca',
//   ),
//   ),
// ),
// child: NavigationBar(
// animationDuration: const Duration(seconds: 1),
// height: 64.0,
// elevation: 22,
// labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//         selectedIndex: _selectedIndex,
//         onDestinationSelected: _onItemTapped,
//         destinations: <NavigationDestination>[
//           NavigationDestination(
//             icon: Icon(
//               Broken.home,
//               color: iconscolor,
//             ),
//             label: 'Home',
// selectedIcon: Icon(
//   Broken.home,
//   color: iconscolor,
// ),
//           ),
//           NavigationDestination(
//             icon: Icon(
//               Broken.search_normal,
//               color: iconscolor,
//             ),
//             label: 'Search',
//           ),
//           NavigationDestination(
//             icon: Icon(
//               Broken.music_library_2,
//               color: iconscolor,
//             ),
//             label: 'Library',
//           ),
//           NavigationDestination(
//             icon: Icon(
//               Broken.profile_2user,
//               color: iconscolor,
//             ),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     ));
//   }
// }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  int _selectedIndex = 0;
  String _currentRoute = '/home';

  bool _showBottomNavBar = true;
  bool _showAppBar = true;

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
        // If already on home and clicked again on Home tab, pop to root
        _navigatorKey.currentState!.popUntil((route) => route.isFirst);
      }
    });
  }

  void _navigateTo(String routeName) {
    setState(() {
      if (_currentRoute != routeName) {
        // if (routeName == '/notifications') {
        //   _showBottomNavBar = false;
        //   _showAppBar = false;
        // } else {
        //   _showBottomNavBar = true;
        //   _showAppBar = true;
        // }
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
        return LibraryScreen();
      case '/profile':
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: null,
                    child: Icon(
                      Broken.menu,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
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
              // actions: [
              //   // IconButton(
              //   //   icon: Icon(Icons.notifications),
              //   //   onPressed: () {
              //   //     _navigateTo('/notifications');
              //   //   },
              //   // ),
              //   // IconButton(
              //   //   icon: Icon(Icons.home),
              //   //   onPressed: () {
              //   //     _navigateTo('/home');
              //   //   },
              //   // ),
              //   // IconButton(
              //   //   icon: Icon(Icons.person),
              //   //   onPressed: () {
              //   //     _navigateTo('/profile');
              //   //   },
              //   // ),
              //   IconButton(
              //     icon: Icon(Icons.settings),
              //     onPressed: () {
              //       _navigateTo('/settings');
              //     },
              //   ),
              // ],
            )
          : null,
      body: Navigator(
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
              builder = (BuildContext _) => LibraryScreen();
              break;
            case '/profile':
              builder = (BuildContext _) => ProfileScreen();
              break;
            default:
              builder = (BuildContext _) => HomeScreen();
          }
          return CupertinoPageRoute(builder: builder, settings: settings);
        },
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
                  icon: Icon(Broken.home_1),
                  label: 'Home',
                  selectedIcon: Icon(
                    Broken.home_1,
                    color: iconscolor,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(Broken.search_normal),
                  label: 'Search',
                  selectedIcon: Icon(
                    Broken.search_normal,
                    color: iconscolor,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(Broken.music_library_2),
                  label: 'library',
                  selectedIcon: Icon(
                    Broken.music_library_2,
                    color: iconscolor,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(Broken.profile_2user),
                  label: 'Profile',
                  selectedIcon: Icon(
                    Broken.profile_2user,
                    color: iconscolor,
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
