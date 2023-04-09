import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorManager extends ChangeNotifier {
  var branch = [
    "Select Branch",
    "CSE",
    "IT",
    "CSCE",
    "CSSE",
    "EEE",
    "E & Computer",
    "ETC",
    "E & INSTRUMENTATION",
    "E & CONTROL",
    "ELECTRICAL",
    "CIVIL",
    "MECHANICAL",
    "MECHATRONICS",
    "AUTOMOBILE",
    "AEROSPACE"
  ];

  var shchems = ["Scheme-1", "Scheme-2"];
  String currentScheme = "Scheme-1";

  void setScheme(cScheme) {
    currentScheme = cScheme;
    notifyListeners();
  }

  List<int> subjectMarks = [];

  var semester = ["Select Semester", "1", "2", "3", "4", "5", "6", "7", "8"];

  List<String> grades = ['Grade', 'O', 'E', 'A', 'B', 'C', 'D'];

  var sgpa = {
    "O": 10,
    "E": 9,
    "A": 8,
    "B": 7,
    "C": 6,
    "D": 5,
    "F": 4,
  };

  List<String> dropvalue = [];

  bool isElective = false;
  int currentBranchIndex = 0;
  String currentBranch = "Select Branch";
  int currentSemesterIndex = 0;
  var currentSemester = "Select Semester";
  var totalCredit = 0;
  var mainJson = [];
  List currentSubjects = [];

  void setSemester(index) {
    currentSemester = semester[index];
    currentSemesterIndex = index;
    notifyListeners();
  }

  void setBranch(index) {
    currentBranch = branch[index];
    currentBranchIndex = index;
    notifyListeners();
  }

  Future<double> calculateTotalCredit(List subject) async {
    double t = 0;
    for (var element in subject) {
      t = t + int.parse(element['Credit']);
    }
    print(t);
    return t;

    // return subject.map((ob) => t + ob);
  }

  void submit() async {
    loadjsonFirstYear(1);
  }

  Future<double> calculateAchievedCredits(List achievedCredits) async {
    double p = 0;
    for (int element in achievedCredits) {
      p = p + element.toDouble();
    }
    return p;
  }

  Future<double> calculateSgpa(List currentSub, List achivedMarks) async {
    double fin = 0;

    for (int i = 0; i < currentSub.length; i++) {
      // fin + (int.parse(currentSub[i]['Credit']) * achivedMarks[i]);
      // print(currentSub[i]['Credit']);
      // print();
      double t =
          achivedMarks[i] * int.parse(currentSub[i]['Credit']).toDouble();
      fin = fin + t;
    }

    double a = await calculateTotalCredit(currentSub);
    // print(fin);
    double ps = fin / a;

    return ps;
  }

  void dropVal(dropVal, index) {
    dropvalue[index] = dropVal;
    print(dropVal);
    if (dropVal != "Grade") {
      // print("hree");
      subjectMarks[index] = sgpa[dropVal]!;
    }
    print(subjectMarks);
    notifyListeners();
  }

  Future<bool> setDropValue() async {
    currentSubjects = List.empty(growable: true);
    mainJson = List.empty(growable: true);
    subjectMarks = List.empty(growable: true);
    final String response =
        await rootBundle.loadString('assets/json/scheme1.json');
    final json = jsonDecode(response);
    mainJson = json;
    currentSubjects = mainJson[currentBranchIndex - 1]
            [branch[currentBranchIndex]][currentSemesterIndex - 1]
        [semester[currentSemesterIndex]];
    dropvalue = List.filled(currentSubjects.length, "Grade");
    subjectMarks = List.filled(currentSubjects.length, 7);

    //    final String response =
    //     await rootBundle.loadString('assets/json/scheme1.json');
    // final json = jsonDecode(response);
    //   mainJson = json;
    // currentSubjects = mainJson[currentBranchIndex - 1]
    //         [branch[currentBranchIndex]][currentSemesterIndex - 1]
    //     [semester[currentSemesterIndex]];
    // dropvalue = List.filled(currentSubjects.length, "Grade");
    // subjectMarks = List.filled(currentSubjects.length, 7);

    notifyListeners();
    return true;
  }

  loadjsonFirstYear(scheme) async {
    // if (scheme == 1) {
    // final String response =
    //     await rootBundle.loadString('assets/json/scheme1.json');
    // final json = jsonDecode(response);
    // mainJson = json;
    // print(mainJson[0]["CSE"][0]["1"]);

    // currentSubjects = mainJson[currentBranchIndex][branch[currentBranchIndex]]
    //     [currentSemesterIndex][semester[currentSemesterIndex]];
    // print(currentSubjects.length);

    // print(subjects.length);
    // subjectMarks = List.filled(currentSubjects.length, 7);
    // print("hello");
    // print(currentSubjects);
    // var credits = await calculateTotalCredit(currentSubjects);
    // var d = await calculateAchievedCredits(subjectMarks);
    // print(d);

    var u = await calculateSgpa(currentSubjects, subjectMarks);
    print(u);

    return u;

    // print(await calculateTotalCredit(currentSubjects));

    // Char c = "C";
    // } else {
    //   final String response =
    //       await rootBundle.loadString('assets/json/scheme2.json');
    //   final json = jsonDecode(response);
    // }
  }
}
