import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

Widget CustomBottomNavigationBar(
    Key bottomNavigationKey, Function setPages, int index) {
  return CurvedNavigationBar(
    animationCurve: Curves.easeIn,
    buttonBackgroundColor: Colors.cyan.shade700,
    key: bottomNavigationKey,
    backgroundColor: const Color.fromARGB(255, 8, 8, 8),
    animationDuration: const Duration(milliseconds: 300),
    index: index,
    color: const Color.fromARGB(255, 27, 25, 25),
    items: const <Widget>[
      Icon(
        Icons.add,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        Icons.home,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        Icons.favorite,
        size: 30,
        color: Colors.white,
      ),
    ],
    onTap: (index) {
      setPages(index);
      // setState(() {
      //   _page = index;
      // });
    },
  );
}
