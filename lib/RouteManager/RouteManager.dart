import 'package:flutter/material.dart';
import 'package:kiitconnect_app/Components/Calculator/Calculator.dart';
import 'package:kiitconnect_app/Components/FileManager/Filemanager.dart';
import 'package:kiitconnect_app/Components/FileManager/PdfViewer.dart';
import 'package:kiitconnect_app/Components/HomePage/Homepage.dart';
import 'package:kiitconnect_app/Components/HomePage/Homepage2.dart';
import 'package:kiitconnect_app/Components/LoginPage/LoginPage.dart';
import 'package:kiitconnect_app/Components/Screens/SplashScreen.dart';
import 'package:kiitconnect_app/Components/Screens/UserProfileScreen/UserProfileScreen.dart';
import 'package:kiitconnect_app/Components/Syllabus/Syllabus.dart';

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
  static const String syllabus = "./syllabus";
  static const String pdfviewer = "./pdfviewer";
  static const String calculator = "./calculator";

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

      case syllabus:
        return MaterialPageRoute(
          builder: (context) => Syllabus(),
        );
      case pdfviewer:
        return MaterialPageRoute(
          builder: (context) => PdfViewer(),
        );
      case calculator:
        return MaterialPageRoute(
          builder: (context) => const Calculator(),
        );

      default:
        throw const FormatException("Wrong Format Value");
    }
  }
}
