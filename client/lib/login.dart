import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'sign_up.dart';
import 'error.dart';

import 'data/rest_client.dart';
import 'data/custom_log_interceptor.dart';

bool valid = false;

class HomeyLogin extends StatelessWidget {
  HomeyLogin({Key? key, required this.email, required this.name})
      : super(key: key);
  final String email;
  final String name;
  final dio = Dio()..interceptors.add(CustomLogInterceptor());
  final prefs = SharedPreferences.getInstance();

  void setString(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', accessToken);
    prefs.setString('refreshToken', refreshToken);
  }

  Widget paging(bool valid) {
    if (valid) {
      return const Homey();
    } else {
      return const SignUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    final restClient = RestClient(dio);

    var userdata = {
      'email': email,
      'name': name,
    };
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: FutureBuilder<Data?>(
        future: restClient.authentication(jsondata: userdata),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Data? authenticationResult = snapshot.data;
            if (authenticationResult != null) {
              if (authenticationResult.alreadyRegistered == true) {
                valid = true;
              } else {
                valid = false;
              }
              setString(authenticationResult.accessToken,
                  authenticationResult.refreshToken);
              return paging(valid);
            }
          }
          return const ErrorPage();
        },
      )),
    );
  }
}
