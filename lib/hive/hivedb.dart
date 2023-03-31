import 'package:hive/hive.dart';
import 'package:kiitconnect_app/Model/AuthModel.dart';
import 'package:path_provider/path_provider.dart';

class Hivedb {
  late final Box box;

  static createBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox('ResourcesBox');
    return;
  }

  Future<bool> saveUserToBox(data) async {
    box = await Hive.openBox("UsersDetailsBox");
    box.put("UserInfo", data);
    return true;
  }

  Future<bool> saveUserAddToBox(data) async {
    box = await Hive.openBox("UsersDetailsBox");
    await box.delete("UserAddInfo");
    await box.put("UserAddInfo", data);
    return true;
  }

  Future<bool> checkIfUserExist() async {
    box = await Hive.openBox("UsersDetailsBox");
    var res = await box.get("UserInfo");
    if (res != null) {
      return true;
    }

    return false;
  }

  Future<bool> checkIfAdditionalInfoExist() async {
    box = await Hive.openBox("UsersDetailsBox");
    var res = await box.get("UserAddInfo");
    if (res != null) {
      return true;
    }

    return false;
  }

  Future<AuthModel> getUserDetails() async {
    box = await Hive.openBox("UsersDetailsBox");
    var res = await box.get("UserInfo");
    AuthModel authModel = AuthModel(
        displayName: res['displayName'],
        email: res['email'],
        profilePic: res['profilePic']);

    return authModel;
  }

  Future<AdditionalInfo> getUserAddDetails() async {
    box = await Hive.openBox("UsersDetailsBox");
    var json = await box.get("UserAddInfo");
    print("UserADD: $json");
    if (json != null) {
      AdditionalInfo additionalInfo = AdditionalInfo(
        batch: json['batch'],
        branch: json['branch'],
        currentSemester: json['currentSemester'],
        currentYear: json['currentYear'],
        yop: json['yop'],
        social: json['social'],
      );

      return additionalInfo;
    }

    return AdditionalInfo(
        batch: null,
        branch: null,
        currentYear: null,
        currentSemester: null,
        social: null,
        yop: null);
  }
}
