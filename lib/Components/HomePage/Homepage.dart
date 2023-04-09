import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiitconnect_app/Components/FileManager/Filemanager.dart';
import 'package:kiitconnect_app/Components/HomePage/Homepage2.dart';
import 'package:kiitconnect_app/Components/Screens/UserProfileScreen/UserProfileScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _page = 1;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  var body = [
    const UserProfileScreen(),
    const HomePage2(),
    const FileManager(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    setPages(index) {
      setState(() {
        _page = index;
      });
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 8, 8),
      bottomNavigationBar: BottomNavigationBar(
        //  splashRadius: 18.0,

        currentIndex: _page,
        onTap: (value) {
          setPages(value);
        },
        selectedItemColor: Colors.grey.shade400,
        unselectedItemColor: Colors.grey.shade600,
        backgroundColor: const Color.fromARGB(255, 27, 27, 27),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        selectedIconTheme: const IconThemeData(size: 23),
        unselectedIconTheme: const IconThemeData(size: 20),
        items: const [
          BottomNavigationBarItem(

              // backgroundColor: Colors.red,
              activeIcon: Icon(FontAwesomeIcons.solidMessage),
              icon: Icon(
                FontAwesomeIcons.message,
              ),
              label: "Community"),
          BottomNavigationBarItem(
              activeIcon: Icon(FontAwesomeIcons.house),
              icon: Icon(
                FontAwesomeIcons.house,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              activeIcon: Icon(FontAwesomeIcons.solidFile),
              icon: Icon(
                FontAwesomeIcons.file,
              ),
              label: "Resources"),
          BottomNavigationBarItem(
              activeIcon: Icon(FontAwesomeIcons.solidUser),
              icon: Icon(
                FontAwesomeIcons.user,
              ),
              label: "Profile"),
        ],
      ),
      // bottomNavigationBar: NavigationBar(
      //   selectedIndex: _page,
      //   onDestinationSelected: (value) {
      //     setPages(value);
      //   },
      //   backgroundColor: const Color.fromARGB(255, 27, 27, 27),
      //   elevation: 50,
      //   labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      //   height: 70,
      //   destinations: const [
      //     NavigationDestination(
      //         icon: Icon(Icons.verified_user), label: "Profile"),
      //     NavigationDestination(icon: Icon(Icons.home), label: "Home"),
      //     NavigationDestination(icon: Icon(Icons.favorite), label: "Files"),
      //     NavigationDestination(icon: Icon(Icons.mail), label: "Mail"),
      //   ],
      // ),

      body: body[_page],
      // body: _page == 0
      //     ? const UserProfileScreen()
      //     : _page == 2
      //         ? const FileManager()
      //         : _page == 1
      //             ? const HomePage2()
      //             : Container(
      //                 color: const Color.fromARGB(255, 8, 8, 8),
      //                 child: Center(
      //                   child: Column(
      //                     children: <Widget>[
      //                       Text(_page.toString(), textScaleFactor: 10.0),
      //                       ElevatedButton(
      //                         child: const Text('Go To Page of index 1'),
      //                         onPressed: () {
      //                           //Page change using state does the same as clicking index 1 navigation button
      //                           final CurvedNavigationBarState? navBarState =
      //                               _bottomNavigationKey.currentState;
      //                           navBarState?.setPage(1);
      //                         },
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ));
    );
  }
}
