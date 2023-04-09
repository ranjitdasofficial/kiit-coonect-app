import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kiitconnect_app/Components/FileManager/ViewPdf.dart';
import 'package:kiitconnect_app/Model/DriveModal.dart';
import 'package:kiitconnect_app/Model/Users.dart';
import 'package:kiitconnect_app/StateManager/FileManagerProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchUrl(url) async {
    print(url);

    // if (await canLaunchUrl(url)) {

    // }
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
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
                color: Colors.grey.shade500, fontWeight: FontWeight.bold),
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
                        onTap: () async {
                          if (value.tempLoist[index].type == "folder") {
                            value.onlistNavigate(index);
                          } else {
                            Directory directory =
                                await getApplicationDocumentsDirectory();
                            File file = File(
                                '${directory.path}/pdfFiles/${value.tempLoist[index].name}');

                            await value.createDirectory();
                            value
                                .downloadFile(value.tempLoist[index].name)
                                .then((val) async {
                              if (val) {
                                Get.to(() => ViewPdf(
                                      file: file,
                                    ));
                              } else {
                                final CancelToken cancelToken = CancelToken();
                                // _cancelToken = CancelToken();

                                try {
                                  Get.defaultDialog(
                                      title: "Downloading...",
                                      backgroundColor: Colors.grey.shade800,
                                      titleStyle:
                                          const TextStyle(color: Colors.white),
                                      middleTextStyle:
                                          const TextStyle(color: Colors.white),
                                      textCancel: "Cancel",
                                      onCancel: () {
                                        cancelToken.cancel();
                                      },
                                      cancelTextColor: Colors.white,
                                      confirmTextColor: Colors.white,
                                      buttonColor: Colors.red,
                                      barrierDismissible: false,
                                      radius: 10,
                                      content: Consumer<FileManagerProvider>(
                                        builder: (context, value, child) {
                                          return Column(
                                            children: [
                                              Text(
                                                  (value.downloadProgress * 100)
                                                      .toStringAsFixed(2)),
                                            ],
                                          );
                                        },
                                      ));

                                  await value.dio.download(
                                      "https://drive.google.com/uc?export=download&id=${value.tempLoist[index].id}",
                                      file.path, onReceiveProgress:
                                          (receivedBytes, totalBytes) {
                                    value.setDownloadProgress(
                                        receivedBytes / totalBytes);
                                  }, cancelToken: cancelToken).catchError((e) {
                                    if (e.type == DioErrorType.cancel) {
                                      Get.snackbar(
                                          "Message", "Download Cancelled");
                                      value.downloadProgress = 0;
                                    } else {
                                      throw e;
                                      // Get.snackbar("Error",
                                      //     "Something went Wrong! Check Internet Connection!");
                                    }

                                    // print("error:$");
                                  }).then((v) {
                                    value.downloadProgress = 0;
                                    print("executed");
                                    if (cancelToken.isCancelled) {
                                    } else {
                                      Get.off(() => ViewPdf(file: file));
                                    }
                                  });
                                } on DioError catch (e) {
                                  if (e.type == DioErrorType.other) {
                                    Get.snackbar(
                                        "Error", "No internet Connection!");
                                  }
                                } catch (e) {
                                  // print(e);
                                }

                                // if (res == null) {
                                //   print("null");
                                //   Get.off(() => const FileManager());
                                // } else {
                                //   value.downloadProgress = 0;
                                //   print("executed");
                                //   if (cancFadeInAnimationelToken.isCancelled) {
                                //   } else {
                                //     Get.to(() => ViewPdf(file: file));
                                //   }
                                // }

                                // setState(() {
                                //   count++;
                                //   // _downloadProgress = 0;
                                // });
                              }
                            });
                          }
                        },
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 90),
                          child: SlideAnimation(
                            // verticalOffset: 50,
                            child: FadeInAnimation(
                              child: ListTile(
                                subtitle: Text(value.tempLoist[index].type !=
                                        "folder"
                                    ? "${((value.tempLoist[index].size)! / 1000000).toStringAsFixed(2)} MB"
                                    : ""),
                                leading: value.tempLoist[index].type == "folder"
                                    ? Icon(
                                        Icons.folder,
                                        color: Colors.grey.shade400,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.filePdf,
                                        color: Colors.red.shade500,
                                      ),
                                trailing:
                                    value.tempLoist[index].type == "folder"
                                        ? null
                                        : IconButton(
                                            onPressed: () {
                                              _launchUrl(
                                                  "https://drive.google.com/file/d/${value.tempLoist[index].id}/view");
                                            },
                                            icon: const Icon(
                                              FontAwesomeIcons.googleDrive,
                                              color: Colors.grey,
                                              size: 20,
                                            )),
                                title: Text(
                                  value.tempLoist[index].name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400),
                                ),
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
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: CircularProgressIndicator()));
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






          