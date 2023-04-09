import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kiitconnect_app/Components/HomePage/Homepage.dart';
import 'package:kiitconnect_app/StateManager/LoginState.dart';
import 'package:kiitconnect_app/hive/hivedb.dart';
import 'package:provider/provider.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key, required this.email});

  final String email;

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  String? selectedValue;

  List<String> yearOfPassing = [
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2028",
    "2029",
    "2030",
  ];

  List<String> batch = [
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
  ];

  List<String> branch = [
    "CSE",
    "IT",
  ];

  List<String> currentSemester = [
    "Sem-1",
    "Sem-2",
    "Sem-3",
    "Sem-4",
    "Sem-5",
    "Sem-6",
    "Sem-7",
    "Sem-8",
  ];

  List<String> currentYear = [
    "First",
    "Second",
    "Third",
    "Fourth",
  ];

  String? selectedyop;
  String? selectedbranch;
  String? selectedCurrentYear;
  String? selectedCurrentSemester;
  String? selectedbatch;

  late TextEditingController github;
  late TextEditingController linkedin;
  late TextEditingController hackerRank;
  late TextEditingController others;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    github.dispose();
    linkedin.dispose();
    hackerRank.dispose();
    others.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    github = TextEditingController();
    linkedin = TextEditingController();
    hackerRank = TextEditingController();
    others = TextEditingController();
    getEditData();
  }

  getEditData() async {
    await Hivedb().getUserAddDetails().then((value) async {
      setState(() {
        selectedbatch = value.batch;
        selectedbranch = value.branch;
        selectedyop = value.yop;
        selectedCurrentSemester = value.currentSemester;
        selectedCurrentYear = value.currentYear;
        // print(value.social);
        print(value.social?[0]['linkedin']);
        linkedin.text = value.social?[0]['linkedin'] ?? "null";
        github.text = value.social?[1]['github'] ?? "null";
        hackerRank.text = value.social?[2]['hackerRank'] ?? "null";
        others.text = value.social?[3]['others'] ?? "null";
      });

      try {
        var checkDb = await context
            .read<LoginState>()
            .checkAdditionalDbExist(widget.email);

        if (checkDb != null) {
          var res = await Hivedb().getUserAddDetails();
          setState(() {
            selectedbatch = res.batch;
            selectedbranch = res.branch;
            selectedyop = res.yop;
            selectedCurrentSemester = res.currentSemester;
            selectedCurrentYear = res.currentYear;
            linkedin.text = value.social?[0]['linkedin'] ?? "Set";
            github.text = value.social?[1]['github'] ?? "Set";
            hackerRank.text = value.social?[2]['hackerRank'] ?? "Set";
            others.text = value.social?[3]['others'] ?? "Set";
          });
        }
      } catch (e) {
        Get.snackbar("Message", "No internet Connection");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 8, 8, 8),
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: Hivedb().getUserDetails(),
              builder: (context, snapshot) {
                var d = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(100), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(50), // Image radius
                          child: d?.profilePic == null
                              ? Image.asset("assets/images/kiit.png")
                              : CachedNetworkImage(
                                  imageUrl: d!.profilePic,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                      child: const CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Image.asset("assets/images/kiit.png"),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text("${d?.displayName}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text("${d?.email}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: chooseOption(selectedbatch ?? "Batch", (val) {
                        setState(() {
                          selectedbatch = val;
                        });
                      }, batch, "Batch"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: chooseOption(selectedbranch ?? "Branch", (val) {
                        setState(() {
                          selectedbranch = val;
                        });
                      }, branch, "Branch"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: chooseOption(selectedCurrentYear ?? "CurrentYear",
                          (val) {
                        setState(() {
                          selectedCurrentYear = val;
                        });
                      }, currentYear, "Current Year"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: chooseOption(
                          selectedCurrentSemester ?? "CurrentSemester", (val) {
                        setState(() {
                          selectedCurrentSemester = val;
                        });
                      }, currentSemester, "Current Semester"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child:
                          chooseOption(selectedyop ?? "YearOfPassing", (val) {
                        setState(() {
                          selectedyop = val;
                        });
                      }, yearOfPassing, "Year Of Passing"),
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextField(

                          // maxLines: 1,
                          controller: linkedin,
                          style:
                              const TextStyle(fontSize: 17, color: Colors.grey),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20.0),
                              label: const Text("Linkedin"),
                              // filled: true,
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade600),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.teal.shade600),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              hintText: 'Linkedin url (optional)',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextField(

                          // maxLines: 1,

                          controller: github,
                          style:
                              const TextStyle(fontSize: 17, color: Colors.grey),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20.0),
                              label: const Text("Github"),
                              // filled: true,
                              labelStyle: const TextStyle(color: Colors.teal),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              hintText: 'Github url (optional)',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextField(
                          controller: hackerRank,
                          // maxLines: 1,
                          style:
                              const TextStyle(fontSize: 17, color: Colors.grey),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20.0),
                              label: const Text("HackerRank"),
                              labelStyle: const TextStyle(color: Colors.teal),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              hintText: 'HackerRank url (optional)',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextField(
                          controller: others,
                          // maxLines: 1,
                          style:
                              const TextStyle(fontSize: 17, color: Colors.grey),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20.0),
                              label: const Text("Other"),
                              // filled: true,

                              labelStyle: const TextStyle(color: Colors.teal),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              hintText: 'Other url (optional)',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ))),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            var data = {
                              "branch": selectedbranch,
                              "batch": selectedbatch,
                              "currentSemester": selectedCurrentSemester,
                              "yop": selectedyop,
                              "currentYear": selectedCurrentYear,
                              "social": [
                                {
                                  "name": "github",
                                  "github": github.text ?? "Set",
                                },
                                {
                                  "name": "linkedin",
                                  "linkedin": linkedin.text ?? "Set",
                                },
                                {
                                  "name": "hackerRank",
                                  "hackerRank": hackerRank.text ?? "Set",
                                },
                                {
                                  "name": "others",
                                  "others": others.text ?? "set"
                                }
                              ]
                            };

                            try {
                              await context
                                  .read<LoginState>()
                                  .modifyAddionalData(
                                      widget.email,
                                      selectedbatch ?? "Set",
                                      selectedbranch ?? "set",
                                      selectedCurrentSemester ?? "Set",
                                      selectedCurrentYear ?? "Set",
                                      github.text ?? "Set",
                                      hackerRank.text ?? "Set",
                                      linkedin.text ?? "Set",
                                      others.text ?? "Set",
                                      selectedyop ?? "Set")
                                  .then((value) async {
                                if (value) {
                                  Get.snackbar("Message", "Details Updated!!");
                                  var hive =
                                      await Hive.openBox("UsersDetailsBox");
                                  hive.delete("UserAddInfo");
                                  var res =
                                      await Hivedb().saveUserAddToBox(data);
                                  if (res) {
                                    Get.offAll(() => const HomePage());
                                  } else {
                                    Get.snackbar(
                                        "Failed", "Something Went Wrong!!");
                                  }
                                  print(data);
                                }
                              });
                            } catch (e) {
                              Get.snackbar("Message", e.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.teal.shade600,
                              elevation: 3),
                          child: Consumer<LoginState>(
                            builder: (context, value, child) {
                              return value.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text("Save");
                            },
                          ),
                        )),
                    const SizedBox(
                      height: 9,
                    )
                  ],
                );

                // return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  Widget chooseOption(name, Function fun, List<String> items, title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 5),
            child: Text(
              "$title",
              style: TextStyle(
                  color: Colors.grey.shade500, fontWeight: FontWeight.bold),
            ),
          ),
          DropdownButtonFormField2(
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.teal),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              labelStyle: const TextStyle(color: Colors.teal),

              contentPadding: EdgeInsets.zero,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            hint: Text(
              '$name',
              style: const TextStyle(fontSize: 14),
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.teal),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              fun(value.toString());
              print(value.toString());
              //Do something when changing the item if you want.
            },
            onSaved: (value) {
              // selectedValue = value.toString();
              // print(selectedValue);
            },
            buttonStyleData: const ButtonStyleData(
              height: 50,
              padding: EdgeInsets.only(left: 1, right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.teal,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal.shade600),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
