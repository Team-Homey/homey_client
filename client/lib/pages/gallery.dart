import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryShow extends StatefulWidget {
  const GalleryShow({Key? key}) : super(key: key);

  @override
  GalleryShowState createState() => GalleryShowState();
}

class GalleryShowState extends State<GalleryShow> {
  List<String> images = [
    'assets/images/sampleImage/png/image1.png',
    'assets/images/sampleImage/png/image2.png',
    'assets/images/sampleImage/png/image3.png',
    'assets/images/sampleImage/png/image4.png',
    'assets/images/sampleImage/png/image5.png',
    'assets/images/sampleImage/png/image6.png',
    'assets/images/sampleImage/png/image7.png',
    'assets/images/sampleImage/png/image8.png',
    'assets/images/sampleImage/png/image9.png',
    'assets/images/sampleImage/png/image10.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1 / 1,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: FloatingActionButton(
            onPressed: () async {
              print("aa");
              final ImagePicker picker = ImagePicker();
              final XFile? pickimage =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickimage != null) {
                setState(() {
                  images.add('assets/images/sampleImage/png/image11.png');
                });
              }
            },
            child: const Icon(Icons.add, color: Colors.white, size: 40),
          ),
        ),
      ],
    ));
  }
}
