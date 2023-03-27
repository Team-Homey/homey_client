import 'package:flutter/material.dart';

class GalleryShow extends StatefulWidget {
  const GalleryShow({Key? key}) : super(key: key);

  @override
  _galleryShowState createState() => _galleryShowState();
}

class _galleryShowState extends State<GalleryShow> {
  List<String> images = [
    'assets/images/sampleImage/png/image1.png',
    'assets/images/sampleImage/png/image2.png',
    'assets/images/sampleImage/png/image3.png',
    'assets/images/sampleImage/png/image4.png',
    'assets/images/sampleImage/png/image5.png',
    'assets/images/sampleImage/png/image6.png',
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
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white, size: 40),
          ),
        ),
      ],
    ));
  }
}
