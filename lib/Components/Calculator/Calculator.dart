import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiitconnect_app/Components/Calculator/CalculationPage.dart';
import 'package:kiitconnect_app/StateManager/CalculatorManager.dart';
import 'package:provider/provider.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // String semesterVal = 'Select Semester';
  // String dropvalues = 'Select Branch';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("CGPA Calculator"),
          backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        ),
        body: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 15, 14, 14)),
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Consumer<CalculatorManager>(
              builder: (context, value, child) {
                return Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 29, 28, 28),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          dropdownColor: const Color.fromARGB(255, 29, 28, 28),
                          // isExpanded: true,
                          elevation: 0,
                          underline: Container(),
                          alignment: Alignment.center,
                          value: value.currentSemester,
                          items: <String>[
                            'Select Semester',
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              alignment: Alignment.center,
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            value
                                .setSemester(value.semester.indexOf(newValue!));

                            // value.setSemester(
                            //     value.currentSemester.indexOf(newValue!));
                            // setState(() {
                            //   dropvalue = newValue!;
                            // });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        // padding: const EdgeInsets.all(14),
                        //  padding: EdgeInsets.only(right: 20),
                        width: MediaQuery.of(context).size.width - 100,
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 29, 28, 28),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          dropdownColor: const Color.fromARGB(255, 29, 28, 28),
                          elevation: 0,
                          underline: Container(),
                          alignment: Alignment.center,
                          value: value.currentBranch,
                          items: <String>[
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
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              alignment: Alignment.center,
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            value.setBranch(value.branch.indexOf(newValue!));

                            // setState(() {
                            //   // dropvalues = newValue!;
                            // });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 45,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 45, 44, 44)),
                          ),
                          onPressed: () {
                            if (value.currentBranch == "Select Branch") {
                              Get.snackbar(
                                "Warning!",
                                "Please select branch to continue!!",
                                animationDuration:
                                    const Duration(milliseconds: 100),
                                duration: const Duration(milliseconds: 1000),
                                dismissDirection: DismissDirection.horizontal,
                                isDismissible: true,
                              );
                            } else if (value.currentSemester ==
                                "Select Semester") {
                              Get.snackbar(
                                "Warning!",
                                "Please select branch to continue!!",
                                animationDuration:
                                    const Duration(milliseconds: 100),
                                duration: const Duration(milliseconds: 1000),
                                dismissDirection: DismissDirection.horizontal,
                                isDismissible: true,
                              );
                            } else {
                              value.setDropValue().then((value) {
                                if (value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CalculationPage(),
                                      ));
                                }
                              });
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ]);
              },
            ),
          ),
        ));
  }
}




//  if (value.currentBranch == "Select Branch") {
//                             Get.snackbar(
//                               "Warning!",
//                               "Please select branch to continue!!",
//                               animationDuration:
//                                   const Duration(milliseconds: 100),
//                               duration: const Duration(milliseconds: 1000),
//                               dismissDirection: DismissDirection.horizontal,
//                               isDismissible: true,
//                             );
//                           } else if (value.currentSemester ==
//                               "Select Semester") {
//                             Get.snackbar(
//                               "Warning!",
//                               "Please select branch to continue!!",
//                               animationDuration:
//                                   const Duration(milliseconds: 100),
//                               duration: const Duration(milliseconds: 1000),
//                               dismissDirection: DismissDirection.horizontal,
//                               isDismissible: true,
//                             );
//                           } else {
//                             value.setDropValue().then((value) {
//                               if (value) {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const CalculationPage(),
//                                     ));
//                               }
//                             });
//                           }