import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import '../data/custom_log_interceptor.dart';
import '../data/rest_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late var _accessToken = '';
  late SharedPreferences _prefs;

  final dio = Dio()..interceptors.add(CustomLogInterceptor());
  final prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  _loadToken() async {
    final restClient = RestClient(dio);
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = _prefs.getString('accessToken') ?? '';
    });
    // FutureBuilder<String?>(
    //   future: restClient.getMyFamilyString(token: 'Bearer $_accessToken'),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       String? fmaily = snapshot.data;
    //       return Text('$fmaily');
    //     }
    //     return Container(
    //       child: Text('Family error1'),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    List<String> family_member = ["Yurim", "Yohan", "Taejin", "Seoyeon"];
    int me = 0;
    return MaterialApp(
      //set Background

      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3FFFA),
              Color(0xFFFFFFFF),
            ],
          )),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: const AssetImage('assets/images/honeyCombBar.png'),
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Image(
                image: const AssetImage('assets/images/honeyComb.png'),
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              // family progile listview
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: family_member.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          CircularProfileAvatar(
                            '',
                            borderColor: index == me
                                ? const Color(0xFFFFC107)
                                : Colors.white,
                            borderWidth: 3,
                            elevation: 5,
                            radius: 40,
                            child: const Image(
                              image: AssetImage('assets/images/unknown.png'),
                            ),
                          ),
                          Text(family_member[index]),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
