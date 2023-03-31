import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kiitconnect_app/Components/Cardbox.dart';
import 'package:kiitconnect_app/FileManager/Filemanager.dart';
import 'package:kiitconnect_app/LoginPage/LoginPage.dart';
import 'package:kiitconnect_app/StateManager/FileManagerProvider.dart';
import 'package:kiitconnect_app/StateManager/LoginState.dart';
import 'package:kiitconnect_app/Themes/mythemes.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  List<String> names = ["Coding", "Academic Resources"];
  List<String> images = [
    "assets/images/code.png",
    "assets/images/academic.png"
  ];

  GlobalThemes globalThemes = GlobalThemes();
  late TextEditingController search;
  late FocusNode focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    search = TextEditingController();
    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => update());

    context.read<FileManagerProvider>().test();
  }

  update() async {
    // await Hivedb.createBox();

    Box box = await Hive.openBox("ResourcesBox");
    String url =
        "https://raw.githubusercontent.com/amitpandey-github/data/main/first.json";
    try {
      final response = await http.get(Uri.parse(url));
      // await rootBundle.loadString('assets/json/first.json');
      final json = jsonDecode(response.body);
      print("getting : $json");
      await box.clear();
      await box.put("academicRes", json);
    } catch (socketException) {
      print("No Internet Connection");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    search.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.6,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 28, 27, 27),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi Users",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: globalThemes.colors2['label']),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Good morning",
                                  style: TextStyle(
                                      color: globalThemes.colors['textColor1']),
                                ),
                              ],
                            ),
                            InkWell(
                              splashColor: Colors.green,
                              onTap: () {
                                context
                                    .read<LoginState>()
                                    .signout()
                                    .then((value) {
                                  if (value) {
                                    Get.offAll(() => const LoginPage());
                                  }
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 39, 38, 38),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(
                                  Icons.notifications,
                                  color: globalThemes.colors['IconBtn'],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 50,
                          child: TextField(
                              controller: search,
                              focusNode: focusNode,

                              // maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.grey),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  filled: true,
                                  prefixIcon: Icon(Icons.search,
                                      color: globalThemes.colors2['IconBtn']),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Search',
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ))),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Explore Categories",
                    style: TextStyle(
                        fontSize: 20, color: globalThemes.colors2['label']),
                  ),
                  const Text(
                    "See all",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 150,
                    mainAxisSpacing: 10),
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      splashColor: const Color.fromARGB(255, 46, 44, 44),
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Get.to(() => const FileManager(),
                            fullscreenDialog: true,
                            curve: Curves.linear,
                            duration: const Duration(milliseconds: 100),
                            transition: Transition.leftToRightWithFade,
                            preventDuplicates: true);
                      },
                      child: CardBox(
                        image: AssetImage(images[index]),
                        name: names[index],
                      ));
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
