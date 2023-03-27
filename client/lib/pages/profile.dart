import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/custom_log_interceptor.dart';
import '../data/rest_client.dart';

class ProfileShow extends StatefulWidget {
  const ProfileShow({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileShow> {
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
    FutureBuilder<String?>(
      future: restClient.getMyInfoString(token: 'Bearer $_accessToken'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String? user = snapshot.data;
          return Text('$user');
        }
        return Container(
          child: Text('Profile error1'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text('Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
