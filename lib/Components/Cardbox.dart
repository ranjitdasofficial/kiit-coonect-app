import 'package:flutter/material.dart';

class CardBox extends StatelessWidget {
  CardBox({super.key, required this.image, required this.name});

  String name;
  AssetImage image;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        // width: 20,

        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                width: 2, color: const Color.fromARGB(255, 31, 29, 29)),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Stack(
          children: [
            Center(
              child: Opacity(
                opacity: 0.5,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Image(image: image, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
