import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiitconnect_app/StateManager/CalculatorManager.dart';
import 'package:provider/provider.dart';

class CalculationPage extends StatefulWidget {
  const CalculationPage({super.key});

  @override
  State<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        appBar: AppBar(
          title: const Text("CGPA Calculator"),
          backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        ),
        body: Consumer<CalculatorManager>(
          builder: (context, value, child) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: value.currentSubjects.length + 2,
                itemBuilder: (BuildContext context, index) {
                  if (index == value.currentSubjects.length) {
                    return const SizedBox(
                      height: 20,
                    );
                  }
                  if (index == value.currentSubjects.length + 1) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 70,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.grey.shade900)),
                              onPressed: () async {
                                double res = await value.loadjsonFirstYear(1);
                                Get.defaultDialog(
                                  barrierDismissible: true,
                                  title: "CGPA",
                                  content: Text(
                                      "Your SGPA is ${res.toStringAsFixed(2)}"),
                                );
                              },
                              child: Text(
                                "Calculate SGPA",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container(
                    // width: MediaQuery.of(context).size.width - 300,

                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      // contentPadding: const EdgeInsets.symmetric(horizontal: 20),

                      tileColor: const Color.fromARGB(255, 8, 8, 8),
                      trailing: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(14),
                        focusColor: Colors.black12,
                        dropdownColor: const Color.fromARGB(255, 39, 38, 38),
                        underline: Container(),
                        value: value.dropvalue[index],
                        items: value.grades
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            // alignment: Alignment.center,

                            value: value,

                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          value.dropVal(newValue, index);
                        },
                      ),
                      title: Container(
                          height: 70,
                          // width: MediaQuery.of(context).size.width,
                          // color: Colors.amber,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey.shade800
                              border: Border.all(color: Colors.grey.shade700)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${value.currentSubjects[index]['name']}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Credit: ${value.currentSubjects[index]['Credit']}",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade400),
                              )
                            ],
                          )),
                    ),
                  );
                });
            // return ElevatedButton(
            //     onPressed: () async {
            //       double res = await value.loadjsonFirstYear(1);
            //       Get.defaultDialog(
            //         barrierDismissible: true,
            //         title: "CGPA",
            //         content: Text("Your SGPA is ${res.toStringAsFixed(2)}"),
            //       );
            //     }
            //     // print(value.subjectMarks);
            //     ,
            //     child: const Text("Submit"));
          },
        ));
  }
}
