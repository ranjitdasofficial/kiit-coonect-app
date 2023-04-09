import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kiitconnect_app/Model/DriveModal.dart';
import 'package:path_provider/path_provider.dart';

class FileManagerProvider extends ChangeNotifier {
  List<DriveModal> tempLoist = [];

  // var dt;
  List stack = [];
  String parent = "";

  late Box box;
  Dio dio = Dio();

  double downloadProgress = 0;

  onlistNavigate(index) async {
    if (stack.isEmpty) {
      parent = tempLoist[index].name;
      stack.add(parent);
      List<DriveModal> newtempLoist = await loadJson(parent);
      tempLoist.clear();
      // setState(() {
      tempLoist = newtempLoist;
      print(stack);
      // });
    } else {
      stack.add(tempLoist[index].name);
      String d = "$parent${tempLoist[index].name}";
      List<DriveModal> newtempLoist = await loadJson(d);
      // if (newtempLoist != Null) {
      // setState(() {
      tempLoist.clear();
      tempLoist = newtempLoist;
      print(stack);

      // });
      // }
    }

    notifyListeners();
  }

  void setDownloadProgress(progress) {
    downloadProgress = progress;
    notifyListeners();
  }

  onBackPressed() async {
    if (stack.isNotEmpty) {
      var pop = stack.removeLast();
      print(pop);
      if (parent == pop) {
        List<DriveModal> newtempLoist = await loadJson("First");
        // setState(() {
        tempLoist.clear();
        tempLoist = newtempLoist;
        print(stack);
        // });
      } else if (stack.length == 1) {
        String d = parent;
        print(d);
        List<DriveModal> newtempLoist = await loadJson(d);
        // if (newtempLoist != Null) {
        // setState(() {
        tempLoist.clear();
        tempLoist = newtempLoist;
        print(stack);
        // });
      } else {
        String d = "$parent$pop";
        print(d);
        List<DriveModal> newtempLoist = await loadJson(d);
        // if (newtempLoist != Null) {
        // setState(() {
        tempLoist.clear();
        tempLoist = newtempLoist;
        print(stack);
        // });
      }
    } else {
      return false;
    }

    notifyListeners();
  }

  Future<List<DriveModal>> runinitial() async {
    var res = await loadJson("First");

    tempLoist = res;
    notifyListeners();
    return res;
  }

  void test() {
    loadJson("AECAssignment");
  }

  Future loadJson(jsonKey) async {
    box = await Hive.openBox("ResourcesBox");

    return getDataFromBoxes(jsonKey);
  }

  getDataFromBoxes(jsonKey) async {
    var data = await box.get("academicRes");
    return loadData(jsonKey, data);
  }

  loadData(jsonKey, jsonData) {
    var key = jsonKey;
    var result = findKey(jsonData, key);

    if (result != null) {
      print('Key found: $key');
      print('Details: $result');
      // setState(() {
      //   tempLoist = result;
      // });

      List<DriveModal> newList = convertToModel(result);
      return newList;
    } else {
      print('Key not found: $key');
      return [];
    }
  }

  List<DriveModal> convertToModel(result) {
    List<DriveModal> list = [];

    for (var i = 0; i < result.length; i++) {
      print(result[i]);

      var name = result[i]['name'];
      var id = result[i]['type'] != "folder" ? result[i]['id'] : null;
      var mimeType =
          result[i]['type'] != "folder" ? result[i]['mimeType'] : null;
      var type = result[i]['type'];
      var size = result[i]['type'] != "folder" ? result[i]['size'] : null;

      var newObj = DriveModal(
          name: name,
          id: id,
          mimeType: mimeType,
          type: type,
          size: size != null ? double.parse(size) : null);
      // print("New Object : ${newObj.name}");

      list.add(newObj);
    }

    print(list);

    return list;
  }

  dynamic findKey(dynamic json, String key) {
    if (json is Map) {
      if (json.containsKey(key)) {
        return json[key];
      } else {
        for (var value in json.values) {
          var result = findKey(value, key);
          if (result != null) {
            return result;
          }
        }
      }
    } else if (json is List) {
      for (var value in json) {
        var result = findKey(value, key);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

//Pdf viewer

  Future<void> createDirectory() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Directory imagesDirectory = Directory('${directory.path}/pdfFiles');
    if (!await imagesDirectory.exists()) {
      await imagesDirectory.create(recursive: true);
    }
  }

  Future chechFileExist(File file) async {
    if (file.existsSync()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> downloadFile(String filename) async {
    try {
      // print(_downloadProgress);
      // Create a new Dio instance

      // Get the directory where the downloaded file will be saved
      Directory directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/pdfFiles/$filename');

      return await chechFileExist(file);

      // Start the download process and report the progress
    } catch (e) {
      print('Error downloading file: $e');
      rethrow;
    }
  }
}





  // Get.defaultDialog(
  //             title: "Downloading...",
  //             backgroundColor: Colors.green,
  //             titleStyle: const TextStyle(color: Colors.white),
  //             middleTextStyle: const TextStyle(color: Colors.white),
  //             textConfirm: "Confirm",
  //             textCancel: "Cancel",
  //             cancelTextColor: Colors.white,
  //             confirmTextColor: Colors.white,
  //             buttonColor: Colors.red,
  //             barrierDismissible: false,
  //             radius: 50,
  //             content: Consumer<FileManagerProvider>(
  //               builder: (context, value, child) {
  //                 return Column(
  //                   children: [
  //                     Text("${value.downloadProgress * 100}"),
  //                     ElevatedButton(
  //                         onPressed: () async {
  //                           await dio.download(
  //                             url,
  //                             file.path,
  //                             onReceiveProgress: (receivedBytes, totalBytes) {
  //                               value.setDownloadProgress(
  //                                   receivedBytes / totalBytes);
  //                             },
  //                           ).then((value) {
  //                             Get.off(() => ViewPdf(file: file));
  //                             // Get.to(() => ViewPdf(file: file));

  //                             // setState(() {
  //                             //   count++;
  //                             //   // _downloadProgress = 0;
  //                             // });
  //                           });
  //                         },
  //                         child: const Text("Download"))
  //                   ],
  //                 );
  //               },
  //             ));