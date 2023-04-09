import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

class Syllabus extends StatelessWidget {
  Syllabus({super.key});

  var sylla = [
    "https://raw.githubusercontent.com/ranjitdasofficial/syllabus/main/semester1.png",
    "https://raw.githubusercontent.com/ranjitdasofficial/syllabus/main/semester2.png",
    "https://raw.githubusercontent.com/ranjitdasofficial/syllabus/main/semester3.png",
    "https://raw.githubusercontent.com/ranjitdasofficial/syllabus/main/semester4.png",
    "https://raw.githubusercontent.com/ranjitdasofficial/syllabus/main/semester5.png",
    "https://raw.githubusercontent.com/ranjitdasofficial/syllabus/main/semester6.png",
    "https://raw.githubusercontent.com/ranjitdasofficial/syllabus/main/semester7.png",
    "https://raw.githubusercontent.com/ranjitdasofficial/syllabus/main/semester8.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: sylla.length,
          itemBuilder: (context, index) {
            return syllabusContent(
                context, index, "Semester-${index + 1}", sylla[index]);
          },
        ),
      ),
    );
  }

  Widget syllabusContent(BuildContext context, index, name, content) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade300),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 30,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.all(5),
          child: WidgetZoom(
            fullScreenDoubleTapZoomScale: 2,
            heroAnimationTag: index,
            zoomWidget: CachedNetworkImage(
              imageUrl: "$content",
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}
