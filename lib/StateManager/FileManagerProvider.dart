import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kiitconnect_app/Model/DriveModal.dart';

class FileManagerProvider extends ChangeNotifier {
  List<DriveModal> tempLoist = [];
  // var dt;
  List stack = [];
  String parent = "";

  late Box box;

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
      if (tempLoist[index].type == "folder") {
        stack.add(tempLoist[index].name);
        String d = "$parent${tempLoist[index].name}";
        List<DriveModal> newtempLoist = await loadJson(d);
        // if (newtempLoist != Null) {
        // setState(() {
        tempLoist.clear();
        tempLoist = newtempLoist;
        print(stack);
      } else {
        print(tempLoist[index].id);
      }

      // });
      // }
    }

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

      var newObj =
          DriveModal(name: name, id: id, mimeType: mimeType, type: type);
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
}
