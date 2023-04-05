import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/custom_log_interceptor.dart';
import '../data/rest_client.dart';

class GalleryShow extends StatefulWidget {
  const GalleryShow({Key? key}) : super(key: key);

  @override
  GalleryShowState createState() => GalleryShowState();
}

class GalleryShowState extends State<GalleryShow> {
  String _accessToken = '';
  List<Photo>? photo;
  File _image = File('');

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;
    if (accessToken != null) {
      setState(() {
        _accessToken = accessToken;
      });
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = RestClient(dio);
        List<Photo>? photo =
            await restClient.getFamilyPhoto(token: 'Bearer $_accessToken');
        setState(() {
          this.photo = photo;
          print(photo);
        });
      } catch (error) {
        print(error);
      }
    }
  }

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
                  _image = File(pickimage.path);
                });

                try {
                  final dio = Dio()..interceptors.add(CustomLogInterceptor());
                  final restClient = RestClient(dio);
                  var jsondata1 = {
                    'title': 'test.jpg',
                  };
                  var jsondata2 = FormData.fromMap({
                    'image': await MultipartFile.fromFile(
                      _image.path,
                    ),
                  });

                  Photo? tmp = await restClient.uploadPhotoTitle(
                      token: 'Bearer $_accessToken', jsondata: jsondata1);
                  await restClient.uploadPhoto(
                      token: 'Bearer $_accessToken',
                      id: tmp.id,
                      jsondata: jsondata2);
                } on DioError catch (e) {
                  print('Image upload failed with error ${e.message}');
                }
              }
            },
            child: const Icon(Icons.add, color: Colors.white, size: 40),
          ),
        ),
      ],
    ));
  }
}
