import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import 'custom_log_interceptor.dart';
import 'rest_client.dart';

class DioResultPage extends StatelessWidget {
  DioResultPage({Key? key}) : super(key: key);
  final dio = Dio()
    ..interceptors.add(
      CustomLogInterceptor(),
    );

  @override
  Widget build(BuildContext context) {
    final restClient = RestClient(dio);
    const email = 'leeyou6757@gmail.com';
    // email to json
    final jsonEmail = {
      'email': email,
    };

    return Scaffold(
        appBar: AppBar(
          title: const Text('Dio'),
        ),
        body: Center(
            child: FutureBuilder<Data?>(
          future: restClient.authentication(jsondata: jsonEmail),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Data? authenticationResult = snapshot.data;
              if (authenticationResult != null) {
                return Text(
                  authenticationResult.alreadyRegistered.toString(),
                  style: const TextStyle(fontSize: 24.0),
                );
              }
            }
            return const CircularProgressIndicator();
          },
        )));
  }
}
