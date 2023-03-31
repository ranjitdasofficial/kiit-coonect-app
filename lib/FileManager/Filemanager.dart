import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kiitconnect_app/Model/DriveModal.dart';
import 'package:kiitconnect_app/Model/Users.dart';
import 'package:kiitconnect_app/StateManager/FileManagerProvider.dart';
import 'package:provider/provider.dart';

class FileManager extends StatefulWidget {
  const FileManager({
    super.key,
  });

  @override
  State<FileManager> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  // String data = "";

  late List<Users> users = [];

  late List<DriveModal> drive = [];

  var images = {
    "application/vnd.google-apps.folder": "folder.png",
    "folder": "folder.png",
    "video/x-matroska": "video.png",
    "video/mp4": "video.png",
    "application/pdf": "pdf.png",
    "file": "pdf.png",
    "text/html": "text.png",
    "application/x-rar": "zip.png",
    "application/json": "others.png",
    "text/x-java": "java.png",
    "text/plain": "text.png",
  };

  // List<String> images = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    // getdata();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var res = await context.read<FileManagerProvider>().onBackPressed();
        if (!res) {
          return Future.value(true);
        }
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        appBar: AppBar(
          title: Text(
            "Academic Resources",
            style: TextStyle(
                color: Colors.grey.shade400, fontStyle: FontStyle.italic),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Consumer<FileManagerProvider>(
          builder: (context, value, child) {
            return value.tempLoist.isNotEmpty
                ? ListView.builder(
                    itemCount: value.tempLoist.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          value.onlistNavigate(index);
                        },
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 110),
                          child: ScaleAnimation(
                            // verticalOffset: 50,
                            child: FadeInAnimation(
                              child: ListTile(
                                title: Text(value.tempLoist[index].name),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                // ? ListView.builder(
                //     itemCount: value.tempLoist.length,
                //     itemBuilder: (context, index) {
                //       return InkWell(
                //           onTap: () {
                //             value.onlistNavigate(index);
                //           },
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: GridView.builder(
                //               shrinkWrap: true,
                //               physics: const ScrollPhysics(),
                //               scrollDirection: Axis.vertical,
                //               gridDelegate:
                //                   const SliverGridDelegateWithFixedCrossAxisCount(
                //                       crossAxisCount: 2,
                //                       crossAxisSpacing: 10,
                //                       mainAxisExtent: 150,
                //                       mainAxisSpacing: 10),
                //               itemCount: value.tempLoist.length,
                //               itemBuilder: (context, index) {
                //                 return AnimationConfiguration.staggeredGrid(
                //                   duration: const Duration(minutes: 30),
                //                   position: index,
                //                   columnCount: 2,
                //                   child: SlideAnimation(
                //                     verticalOffset: 10,
                //                     child: InkWell(
                //                       splashColor:
                //                           const Color.fromARGB(255, 46, 44, 44),
                //                       borderRadius: BorderRadius.circular(20),
                //                       onTap: () {
                //                         value.onlistNavigate(index);
                //                       },
                //                       child: CardBox(
                //                           image: value.tempLoist[index]
                //                                       .mimeType !=
                //                                   null
                //                               ? AssetImage(
                //                                   "assets/images/${images[value.tempLoist[index].mimeType]}")
                //                               : AssetImage(
                //                                   "assets/images/${images[value.tempLoist[index].type]}"),
                //                           name: value.tempLoist[index].name),
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                //           ));
                //     },
                //   )
                : const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


//  return InkWell(
//                             onTap: () {
//                               value.addStack(data[index].id);
//                             },
//                             child: CardBox(
//                                 image: const AssetImage(
//                                     "assets/images/folder.png"),
//                                 name: data[index].name));






          