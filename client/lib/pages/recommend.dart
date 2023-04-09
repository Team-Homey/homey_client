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
  late var accessToken;
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
      accessToken = _prefs.getString('accessToken') ?? '';
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
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.25,
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
                      Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 25,
                              alignment: Alignment.center,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tags.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        alignment: Alignment.center,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 245, 245, 245),
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
                                  })))
                    ],
                  ))
            ])));
  }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
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
                                  'Caribbean Bay',
                                  'https://www.google.com/maps/place/%EC%BA%90%EB%A6%AC%EB%B9%84%EC%95%88%EB%B2%A0%EC%9D%B4/data=!3m1!4b1!4m6!3m5!1s0x357b56ae20ac23b3:0x41aa5b7a8a28b20c!8m2!3d37.2971295!4d127.2008973!16s%2Fm%2F05p2_yy',
                                  [
                                    "pool",
                                    "water",
                                    "ocean",
                                    "waterpark",
                                    "blue"
                                  ]),
                              showImage('image2.png', 'Jungmun Beach',
                                  'https://www.google.com/', [
                                "sea",
                                "island",
                              ]),
                              showImage(
                                  'image3.png',
                                  'Banpo Hangang Park',
                                  'https://www.google.com/',
                                  ["river", "colors", "waterfall"]),
                              showImage(
                                  'image4.png',
                                  'Yeouido Hangang Park',
                                  'https://www.google.com/search?q=korea%20han%20river%20park&hl=en&sxsrf=APwXEddXizhFuj3YTZVTRZ_EPjpnYs4qWg:1680218705962&ei=KhomZLzGOtbe-Qam653QDg&ved=2ahUKEwipoPS45oT-AhWZ1GEKHVO4ACYQvS56BAgrEAE&uact=5&oq=korea+han+river+park&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCAAQgAQyBggAEBYQHjICCCYyAggmMgIIJjICCCYyAggmMggIABCKBRCGAzIICAAQigUQhgMyCAgAEIoFEIYDOgoIABBHENYEELADOgoIABCKBRCwAxBDOg0IABDkAhDWBBCwAxgBOhIILhCKBRDUAhDIAxCwAxBDGAJKBAhBGABQ8yBY5SRgrCVoA3ABeACAAXeIAdEDkgEDMC40mAEAoAEByAEOwAEB2gEGCAEQARgJ2gEGCAIQARgI&sclient=gws-wiz-serp&tbs=lrf:!1m4!1u3!2m2!3m1!1e1!1m4!1u2!2m2!2m1!1e1!2m1!1e2!2m1!1e3!3sIAE,lf:1,lf_ui:1&tbm=lcl&rflfq=1&num=10&rldimm=11878392033566344492&lqi=ChRrb3JlYSBoYW4gcml2ZXIgcGFya0ibltaliICAgAhaIBABEAIQAxgBGAMiFGtvcmVhIGhhbiByaXZlciBwYXJrkgEEcGFya5oBI0NoWkRTVWhOTUc5blMwVkpRMEZuU1VOUE5HRklPRmRSRUFFqgE3EAEqEiIOaGFuIHJpdmVyIHBhcmsoADIfEAEiG6Zoxx5gQJCRZYmCfp5p-9MA1uESoXOWbtXSQA&phdesc=FcaQFXP3ii4&sa=X&rlst=f#rlfi=hd:;si:11878392033566344492,l,ChRrb3JlYSBoYW4gcml2ZXIgcGFya0ibltaliICAgAhaIBABEAIQAxgBGAMiFGtvcmVhIGhhbiByaXZlciBwYXJrkgEEcGFya5oBI0NoWkRTVWhOTUc5blMwVkpRMEZuU1VOUE5HRklPRmRSRUFFqgE3EAEqEiIOaGFuIHJpdmVyIHBhcmsoADIfEAEiG6Zoxx5gQJCRZYmCfp5p-9MA1uESoXOWbtXSQA,y,FcaQFXP3ii4;mv:[[37.5399775,127.0977911],[37.5086733,126.89119749999999]];tbs:lrf:!1m4!1u3!2m2!3m1!1e1!1m4!1u2!2m2!2m1!1e1!2m1!1e2!2m1!1e3!3sIAE,lf:1,lf_ui:1',
                                  [
                                    "park",
                                    "river",
                                    "seoul",
                                  ]),
                              showImage('image5.png', 'Daecheon Beach ',
                                  'https://www.google.com/', [
                                "beach",
                              ]),
                              showImage('image6.png', 'Ocean World',
                                  'https://www.google.com/', ["playground"]),
                            ],
                          ))))
            ]))));
  }
}
