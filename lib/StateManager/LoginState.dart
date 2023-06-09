import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kiitconnect_app/Getx/Logindata.dart';
import 'package:kiitconnect_app/Model/AuthModel.dart';
import 'package:kiitconnect_app/Model/DriveModal.dart';
import 'package:kiitconnect_app/hive/hivedb.dart';

class LoginState extends ChangeNotifier {
  late AuthModel authModel;
  final dio = Dio();
  bool isLoggedIn = false;
  bool isLoading = false;
  String message = "User Logged In";
  final googleSignIn = GoogleSignIn();
  late final Box box;
  // late DioCacheManager dioCacheManager;
  late Options _cacheOptions;
  late List<DriveModal> drive = [];

  // late List<String> stack = ["1qTpXYKfoGxkZsCHJJ84PRs7uQFszAyJX"];

  // LoginState() {
  //   isLoggedIn = logindata.read("isLoggedIn") ?? false;
  //   dioCacheManager = DioCacheManager(CacheConfig());
  //   _cacheOptions = buildCacheOptions(const Duration(minutes: 5));
  // }

  // Future<AuthModel> getDetails() async {
  //   var res = await googleSignIn.signIn();
  //   return authModel = AuthModel(res!.displayName, res.email, res.photoUrl);
  // }

  Future storeToDatabase(email, profilePic, displayName) async {
    var res = await dio
        .post("https://kiitconnect.herokuapp.com/api/auth/signup", data: {
      "email": email,
      "profilePic": profilePic,
      "displayName": displayName
    });

    print(res.data['success']);

    if (res.data['success']) {
      // authModel = AuthModel(displayName, email, profilePic);

      var details = {
        "displayName": displayName,
        "profilePic": profilePic,
        "email": email
      };

      Hivedb hivedb = Hivedb();
      await hivedb.saveUserToBox(details);
      isLoggedIn = true;
      message = "AuthSucessFull";
      logindata.write("isLoggedIn", true);

      if (res.data['newUser']) {
        return {"newUser": true, "err": false, "email": email};
      }

      return {"newUser": false, "err": false, "email": email};
    }

    return {"err": true, "newUser": false};
  }

  Future checkIp() async {
    await Future.delayed(const Duration(microseconds: 200));
    return true;
  }

  Future checkAdditionalDbExist(email) async {
    try {
      var value = await dio.post(
          "https://kiitconnect.herokuapp.com/api/auth/getAditionalInfo",
          data: {"email": email});

      print(value.data);
      if (value.data != null) {
        if (value.data['success']) {
          var d = value.data['data'];

          var data = {
            "branch": d['branch'],
            "batch": d['batch'],
            "currentSemester": d['currentSemester'],
            "yop": d['yop'],
            "currentYear": d['currentYear'],
            "social": [
              {"name": "linkedin", "linkedin": d['linkedin']},
              {"name": "github", "github": d['github']},
              {"name": "hackerRank", "hackerRank": d['hackerRank']},
              {"name": "others", "others": d['others']}
            ]
          };

          await Hivedb().saveUserAddToBox(data);

          print("here");
          isLoading = false;
          notifyListeners();
          return true;
        } else {
          isLoading = false;
          notifyListeners();
          print("jo");
          return false;
        }
      }

      print("eexef");
    } on DioError catch (e) {
      isLoading = false;
      notifyListeners();
      print("jsjdd");
      throw e.message;
    }
  }

  Future storeAddionalInfoToDb(email, batch, branch, currentSemester,
      currentYear, github, hackerRank, linkedin, others, yop) async {
    var res = await dio.post(
        "https://kiitconnect.herokuapp.com/api/auth/additionalInfo",
        data: {
          "email": email,
          "branch": branch,
          "batch": batch,
          "currentSemester": currentSemester,
          "currentYear": currentYear,
          "github": github,
          "hackerRank": hackerRank,
          "linkedin": linkedin,
          "others": others,
          "yop": yop
        });

    if (!res.data['success']) {
      return {
        "err": "true",
      };
    } else {
      if (res.data['newUser']) {
        return {
          "err": false,
          "newUser": true,
          "email": email,
        };
      } else {
        return {"err": false, "newUser": false, "email": email};
      }
    }
  }

  Future<bool> modifyAddionalData(email, batch, branch, currentSemester,
      currentYear, github, hackerRank, linkedin, others, yop) async {
    isLoading = true;
    notifyListeners();
    // print({email, branch});
    // var res = http.post(Uri.parse("https://kiitconnect.herokuapp.com/api/auth/UpdateAdditional"),
    //     body: {"email": email});

    // print(res);
    // await dio.post("https://kiitconnect.herokuapp.com/test", data: {email: "21053"});

    try {
      var res = await dio.post(
          "https://kiitconnect.herokuapp.com/api/auth/UpdateAdditional",
          data: {
            // "email": "21053420@kiit.ac.in",
            // "branch": "cse",
            // "batch": "2025",
            // "currentSemester": "CurrentSemester",
            // "currentYear": "2021",
            // "github": "github",
            // "hackerRank": "hackerrank",
            // "linkedin": "linkedin",
            // "others": "others",
            // "yop": "others"
            "email": email,
            "branch": branch,
            "batch": batch,
            "currentSemester": currentSemester,
            "currentYear": currentYear,
            "github": github,
            "hackerRank": hackerRank,
            "linkedin": linkedin,
            "others": others,
            "yop": yop
          });

      print(res);

      if (!res.data['success']) {
        isLoading = false;
        notifyListeners();
        return false;
      } else {
        isLoading = false;
        notifyListeners();
        return true;
      }
    } on DioError catch (e) {
      isLoading = false;
      notifyListeners();
      throw e.message;
    }

    // return false;
  }

  Future<bool> signout() async {
    Box box2 = await Hive.openBox("UsersDetailsBox");
    var res = await googleSignIn.signOut().then((value) => box2.clear());
    isLoggedIn = false;
    isLoading = false;
    notifyListeners();
    return true;
  }

  Future googleLogin() async {
    print("googleLogin method Called");
    var result = await googleSignIn.signIn();
    var email = result!.email.split("@");
    var displayName = result.displayName;
    var profilePic = result.photoUrl;
    print(email);
    if (email[1] != "kiit.ac.in") {
      googleSignIn.signOut();
      isLoggedIn = false;
      message = "Use Kiit mail only";
      isLoading = false;
      notifyListeners();
      return {"err": true, "message": "Login With Kiit Mail Only!!"};
    }
    isLoading = true;
    notifyListeners();
    return storeToDatabase(result.email, profilePic, displayName);

    // googleSignIn.signOut();

    // print("Result $result");
  }

  // void addStack(id) {
  //   stack.add(id);
  //   notifyListeners();
  // }

  // void removeStack() {
  //   stack.removeLast();
  //   notifyListeners();
  // }

  // String getId() {
  //   return stack[stack.length - 1];
  // }

  // Future<List<DriveModal>> getData(id) async {
  //   Dio dio = Dio();
  //   dio.interceptors.add(dioCacheManager.interceptor);
  //   var response = await dio.post(
  //       // "http://192.168.175.113:3000/api/drive/getfoldersonly",
  //       "https://kiitconnect.live/api/drive/getfoldersonly",
  //       options: _cacheOptions,
  //       data: {"id": id});

  //   var data = response.data as List<dynamic>;

  //   // var jsondecode = jsonDecode(data) as List<dynamic>;
  //   // var jsondecode = jsonDecode(data)['employees']['employee'] as List<dynamic>;

  //   // print(jsondecode);

  //   // var jsondecode = jsonDecode(data);

  //   // final List<Users> u = data.map((e) => Users.fromJson(e)).toList();
  //   final List<DriveModal> drivedata =
  //       data.map((e) => DriveModal.fromJson(e)).toList();

  //   return drivedata;
  // }
}
