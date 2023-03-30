import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:slowly_moving_widgets_field/slowly_moving_widgets_field.dart';

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
  late FlutterGifController controller;

  final dio = Dio()..interceptors.add(CustomLogInterceptor());

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadToken() async {
    final restClient = RestClient(dio);
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = _prefs.getString('accessToken') ?? '';
    });
    FutureBuilder<String?>(
      future: restClient.getMyFamilyString(token: 'Bearer $_accessToken'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String? fmaily = snapshot.data;
          return Text('$fmaily');
        }
        return Container(
          child: Text('Family error'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text("aa");
  }
}

// emotion class with self.number
