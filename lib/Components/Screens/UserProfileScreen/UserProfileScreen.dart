import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiitconnect_app/Components/Screens/UserProfileScreen/EditUserProfile.dart';
import 'package:kiitconnect_app/hive/hivedb.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // final Hivedb hivedb = Hivedb();
  var SocialMedia = {
    "linkedin": "assets/images/linkedin.png",
    "github": "assets/images/github.png",
    "hackerRank": "assets/images/instagram.png",
    "others": "assets/images/instagram.png",
  };
  @override
  Widget build(BuildContext context) {
    var topheight = MediaQuery.of(context).size.height / 2.9;
    var imgHeight = topheight - topheight / 5;
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 22, 22, 22),
          ),
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
          Text(
            "${data.displayName}",
            style: TextStyle(
                color: Colors.grey.shade400, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "${data.email}",
            style: TextStyle(color: Colors.grey.shade400),
          ),
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
          color: Color.fromARGB(255, 28, 28, 28),
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
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.grey.shade800)),
              onPressed: () {
                Get.to(() => EditUserProfile(email: data.email));
              },
              child: Text(
                "Edit Profile",
                style: TextStyle(color: Colors.grey.shade300),
              ))
        ],
      ),
    );
  }

  Widget MoreInfoIcon(title, subtitle) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width / 5,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 39, 38, 38),
          border: Border.all(color: Colors.grey.shade700),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title",
            style: TextStyle(
                color: Colors.grey.shade500, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "$subtitle",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
          )
        ],
      ),
    );
  }

  Widget SocialBtn(data) {
    return FutureBuilder(
      future: Hivedb().getUserAddDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          var social = [];

          // snapshot.data?.social?.map((e) => { return print("jsdjsjdjsdjsdj")});
          // if (snapshot.hasData) {

          // }

          // var linkedin = snapshot.data?.social?[0]['linkedin'];
          // var github = snapshot.data?.social?[0]['github'];
          // var hackerRank = snapshot.data?.social?[0]['hackerrank'];
          // var others = snapshot.data?.social?[0]['others'];

          // if (linkedin.length != null && linkedin.length > 0) {
          //   social.add({"linkedin": linkedin});
          // }
          // if (github.length != null && github.length > 0) {
          //   social.add({"github": github});
          // }
          // // if (hackerRank.length != null && hackerRank.length > 0) {
          // //   social.add({"hackerRank": hackerRank});
          // // }
          // if (others.length != null && others.length > 0) {
          //   social.add({"others": others});
          // }

          // print(social);
          // print({linkedin, github, hackerRank, others});

          // print(soc);

          return SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: snapshot.data == null
                    ? List.empty()
                    : snapshot.data!.social != null
                        ? snapshot.data!.social!
                            .where((element) =>
                                element = (element[element['name']].length > 0))
                            .toList()
                            .map((e) {
                            print(snapshot.data);
                            return SocialIcons("${SocialMedia[e['name']]}");
                          }).toList()
                        : List.empty()),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
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
              borderRadius: BorderRadius.circular(100),
              child: SizedBox.fromSize(
                size: Size.fromRadius(topheight / 5),
                child: CachedNetworkImage(
                  imageUrl: "${data.profilePic}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/kiit.png"),
                ),
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
