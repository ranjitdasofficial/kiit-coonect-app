import 'package:flutter/material.dart';
import 'package:kiitconnect_app/FileManager/Filemanager.dart';
import 'package:kiitconnect_app/HomePage/Homepage.dart';
import 'package:kiitconnect_app/HomePage/Homepage2.dart';
import 'package:kiitconnect_app/LoginPage/LoginPage.dart';
import 'package:kiitconnect_app/Screens/SplashScreen.dart';
import 'package:kiitconnect_app/Screens/UserProfileScreen/UserProfileScreen.dart';

class RouteManager {
  static const String Home = "./";
  static const String Home2 = "./homepage2";
  static const String Login = "./login";
  static const String Common = "./common";
  static const String BottomSheetModal = "./bottomsheet";
  static const String BottomPlayer = "./bottom";
  static const String filemanager = "./filemanager";
  static const String splashScreen = "./splashscreen";
  static const String UserProfile = "./UserProfile";
  static const String editUserProfile = "./editUserProfile";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case Home2:
        return MaterialPageRoute(
          builder: (context) => const HomePage2(),
        );
      case filemanager:
        return MaterialPageRoute(
          builder: (context) => const FileManager(),
        );

      case Login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      // case Home:
      //   return MaterialPageRoute(
      //     builder: (context) => MyHomePage(),
      //   );
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case UserProfile:
        return MaterialPageRoute(
          builder: (context) => const UserProfileScreen(),
        );

      default:
        throw const FormatException("Wrong Format Value");
    }
  }
}
