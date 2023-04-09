import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiitconnect_app/Components/HomePage/Homepage.dart';
import 'package:kiitconnect_app/Components/LoginPage/LoginPage.dart';
import 'package:kiitconnect_app/StateManager/FileManagerProvider.dart';
import 'package:kiitconnect_app/hive/hivedb.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Hivedb hivedb;
  @override
  void initState() {
    // TODO: implement initState
    hivedb = Hivedb();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => gotonext());
  }

  gotonext() async {
    // await Future.delayed(const Duration(milliseconds: 50));
    if (await hivedb.checkIfUserExist()) {
      context.read<FileManagerProvider>().runinitial();
      Get.offAll(() => const HomePage());
    } else {
      Get.offAll(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(child: Text("KIIT CONNECT")),
      ),
    );
  }
}
