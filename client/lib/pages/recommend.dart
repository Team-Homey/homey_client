import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/custom_log_interceptor.dart';
import '../data/rest_client.dart';

class RecommendShow extends StatefulWidget {
  const RecommendShow({Key? key}) : super(key: key);

  @override
  RecommendState createState() => RecommendState();
}

class RecommendState extends State<RecommendShow> {
  late var _accessToken = '';
  late SharedPreferences _prefs;
  final dio = Dio()..interceptors.add(CustomLogInterceptor());
  User? user;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  _loadToken() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = _prefs.getString('accessToken') ?? '';
    });
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget showImage(String imagePath, String placeName, String placeAddress,
      List<String> tags) {
    String path = "assets/images/sampleImage/place/$imagePath";
    return GestureDetector(
        onTap: () {
          _launchUrl(Uri.parse(placeAddress));
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset(path, fit: BoxFit.cover)),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Text(placeName,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      // show tags with horizontal scroll
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 25,
                          alignment: Alignment.center,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tags.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 245, 245, 245),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text("  #${tags[index]}  ",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "roboto")));
                              }))
                    ],
                  ))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    final restClient = RestClient(dio);
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
                child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text(' How about this place? ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        fontFamily: "roboto",
                      ))),
              const SizedBox(height: 10),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              showImage(
                                  'image1.png',
                                  'place1',
                                  'https://www.google.com/maps/place/%EC%BA%90%EB%A6%AC%EB%B9%84%EC%95%88%EB%B2%A0%EC%9D%B4/data=!3m1!4b1!4m6!3m5!1s0x357b56ae20ac23b3:0x41aa5b7a8a28b20c!8m2!3d37.2971295!4d127.2008973!16s%2Fm%2F05p2_yy',
                                  [
                                    "pool",
                                    "water",
                                    "ocean",
                                    "waterpark",
                                  ]),
                              showImage('image2.png', 'place2',
                                  'https://www.google.com/', [
                                "water",
                                "ocean",
                                "sea",
                              ]),
                              showImage(
                                  'image3.png',
                                  'place3',
                                  'https://www.google.com/',
                                  ["river", "colors"]),
                              showImage('image4.png', 'place4',
                                  'https://www.google.com/', [
                                "park",
                                "river",
                                "seoul",
                              ]),
                              showImage('image5.png', 'place5',
                                  'https://www.google.com/', [
                                "beach",
                              ]),
                              showImage(
                                  'image6.png',
                                  'place6',
                                  'https://www.google.com/',
                                  ["playground", "water"]),
                            ],
                          ))))
            ]))));
  }
}
