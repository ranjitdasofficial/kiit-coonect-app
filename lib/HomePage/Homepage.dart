import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kiitconnect_app/Components/BottomNavigationbar.dart';
import 'package:kiitconnect_app/FileManager/Filemanager.dart';
import 'package:kiitconnect_app/HomePage/Homepage2.dart';
import 'package:kiitconnect_app/Screens/UserProfileScreen/UserProfileScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _page = 1;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    setPages(index) {
      setState(() {
        _page = index;
      });
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        bottomNavigationBar:
            CustomBottomNavigationBar(_bottomNavigationKey, setPages, _page),
        body: _page == 0
            ? const UserProfileScreen()
            : _page == 2
                ? const FileManager()
                : _page == 1
                    ? const HomePage2()
                    : Container(
                        color: const Color.fromARGB(255, 8, 8, 8),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(_page.toString(), textScaleFactor: 10.0),
                              ElevatedButton(
                                child: const Text('Go To Page of index 1'),
                                onPressed: () {
                                  //Page change using state does the same as clicking index 1 navigation button
                                  final CurvedNavigationBarState? navBarState =
                                      _bottomNavigationKey.currentState;
                                  navBarState?.setPage(1);
                                },
                              )
                            ],
                          ),
                        ),
                      ));
  }
}
