import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = _prefs.getString('accessToken') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final restClient = RestClient(dio);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Home'),
              Text('accessToken: $_accessToken'),
              // FutureBuilder<String?>(
              //     future: restClient.getMyFamilyString(
              //         token: 'Bearer $_accessToken'),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         String? familyMember = snapshot.data;
              //         if (familyMember != null) {
              //           return Text('Family name : $familyMember');
              //         }
              //       }
              //       return Container(
              //         child: Text('Family error1'),
              //       );
              //     })

              FutureBuilder<String?>(
                future:
                    restClient.getMyInfoString(token: 'Bearer $_accessToken'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String? user = snapshot.data;
                    if (user != null) {
                      return Text('Family name : $user');
                    }
                  }
                  return Container(
                    child: Text('Family error1'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
