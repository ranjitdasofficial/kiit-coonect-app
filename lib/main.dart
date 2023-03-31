import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kiitconnect_app/Init/init.dart';
import 'package:kiitconnect_app/RouteManager/RouteManager.dart';
import 'package:kiitconnect_app/StateManager/FileManagerProvider.dart';
import 'package:kiitconnect_app/StateManager/LoginState.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  Init.initAll();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginState>(
          create: (context) => LoginState(),
        ),
        ChangeNotifierProvider<FileManagerProvider>(
          create: (context) => FileManagerProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: "KIIT CONNECT",
        initialRoute: RouteManager.splashScreen,
        onGenerateRoute: RouteManager.generateRoutes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
      ),
    );
  }
}
