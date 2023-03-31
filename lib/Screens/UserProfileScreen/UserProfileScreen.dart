import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiitconnect_app/Screens/UserProfileScreen/EditUserProfile.dart';
import 'package:kiitconnect_app/hive/hivedb.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // final Hivedb hivedb = Hivedb();

  @override
  Widget build(BuildContext context) {
    var topheight = MediaQuery.of(context).size.height / 2.9;
    var imgHeight = topheight - topheight / 5;
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: FutureBuilder(
                future: Hivedb().getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      return Column(
                        children: [
                          Stack(
                              clipBehavior: Clip.none,
                              children: [topHeader(topheight, data)]),
                          UserDetails(imgHeight, data)
                        ],
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          )),
    );
  }

  Widget UserDetails(imgHeight, data) {
    return Padding(
      padding: EdgeInsets.only(top: imgHeight / 3),
      child: Column(
        children: [
          Text("${data.displayName}"),
          Text("${data.email}"),
          const SizedBox(
            height: 20,
          ),
          SocialBtn(data),
          const SizedBox(
            height: 30,
          ),
          Description(imgHeight, data),
        ],
      ),
    );
  }

  Widget Description(imgheight, data) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.9,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "More Info",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: Hivedb().getUserAddDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      var d = snapshot.data;
                      print(d);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MoreInfoIcon("Batch", "${d?.batch}"),
                          MoreInfoIcon("Branch", "${d?.branch}"),
                          MoreInfoIcon("Semester", "${d?.currentSemester}"),
                          MoreInfoIcon("YOP", "${d?.yop}"),
                        ],
                      );
                    } else {
                      return const Text("Empty");
                    }
                  }
                  return const CircularProgressIndicator();
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(() => EditUserProfile(email: data.email));
              },
              child: const Text("Edit Profile"))
        ],
      ),
    );
  }

  Widget MoreInfoIcon(title, subtitle) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width / 5,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 39, 38, 38),
          borderRadius: BorderRadius.all(Radius.circular(100))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("$title"), Text("$subtitle")],
      ),
    );
  }

  Widget SocialBtn(data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SocialIcons("assets/images/instagram.png"),
          SocialIcons("assets/images/github.png"),
          SocialIcons("assets/images/github.png"),
          SocialIcons("assets/images/github.png"),
        ],
      ),
    );
  }

  Widget SocialIcons(images) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          image:
              DecorationImage(image: AssetImage("$images"), fit: BoxFit.cover)),
    );
  }

  Widget topHeader(topheight, data) {
    return Container(
      height: topheight,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/kiit.png"), fit: BoxFit.cover)),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: topheight - topheight / 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(topheight / 5), // Image radius
                child: Image.network('${data.profilePic}', fit: BoxFit.cover),
              ),
            ),
          ),
          // Positioned(
          //   top: topheight / 2,
          //   child: const Text(
          //     "hi i ma progrramaer",
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}
