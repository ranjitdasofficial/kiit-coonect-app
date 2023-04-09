import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiitconnect_app/Components/HomePage/Homepage.dart';
import 'package:kiitconnect_app/Components/Screens/UserProfileScreen/EditUserProfile.dart';
import 'package:kiitconnect_app/StateManager/LoginState.dart';
import 'package:kiitconnect_app/hive/hivedb.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => check());
  }

  // void check() {
  //   if (context.read<LoginState>().isLoggedIn) {
  //     Get.offAll(() => const HomePage());
  //     Get.snackbar(
  //       "Title",
  //       context.read<LoginState>().message,
  //       colorText: Colors.white,
  //       backgroundColor: Colors.lightBlue,
  //       icon: const Icon(Icons.add_alert),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black87,
            bottomOpacity: 0.0,
            scrolledUnderElevation: 0.0),
        body: Consumer<LoginState>(
          builder: (context, value, child) {
            return value.isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black87,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(
                    color: Colors.black87,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(20), // Image border
                              child: SizedBox.fromSize(
                                size:
                                    const Size.fromRadius(100), // Image radius
                                child: Image.network(
                                    'https://ci5.googleusercontent.com/proxy/zVgsIgc750QxXCtzMaFvJUs3qXxr3ERLssf2WyyUIckzgtk_fxZF1-dwgJwhARDb2dnURZB1huT_JePOx57D5BoHTT7ImeaXVC0yqhCwQHOxkPR7U0Zt5B7su0p3CWMxK00ilKAzc8yCZupXcSQakRCwZF6UC2WnmQ=s0-d-e1-ft#https://user-images.githubusercontent.com/112815459/221346528-aad1c0e1-d207-4c0b-a971-0f5d1fc5d290.png',
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 7,
                            ),
                            const Text("Note: Login using kiit mail only!!"),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  // if (context.read<LoginState>().isLoggedIn) {
                                  //   return Get.offAll(() => const HomePage());
                                  // }
                                  var res = await context
                                      .read<LoginState>()
                                      .googleLogin();
                                  if (!res['err']) {
                                    if (!res['newUser']) {
                                      Hivedb hivedb = Hivedb();
                                      print(res['email']);

                                      var po = await context
                                          .read<LoginState>()
                                          .checkIp();

                                      print(po);
                                      await context
                                          .read<LoginState>()
                                          .checkAdditionalDbExist(res['email'])
                                          .then((value) {
                                        if (value) {
                                          Get.offAll(() => const HomePage());
                                        } else {
                                          Get.offAll(() => EditUserProfile(
                                              email: res['email']));
                                        }
                                      });

                                      // print("rp: ${await rp}");
                                    } else {
                                      Get.offAll(() => EditUserProfile(
                                            email: res['email'],
                                          ));
                                    }
                                  } else {
                                    // Get.snackbar("Message", res['message']);
                                    print("Something Went Wrong");
                                  }

                                  Get.snackbar(
                                    "Title",
                                    context.read<LoginState>().message,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.lightBlue,
                                    icon: const Icon(Icons.add_alert),
                                  );
                                },
                                child: const Text("Signin"))
                          ]),
                    ),
                  );
          },
        ));
  }
}
