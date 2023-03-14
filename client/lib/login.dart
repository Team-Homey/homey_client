import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import 'app.dart';
import 'sign_up.dart';
import 'data/rest_client.dart';
import 'data/custom_log_interceptor.dart';

bool valid = false;

// home_login(email, name)
class HomeyLogin extends StatelessWidget {
  HomeyLogin({Key? key, required this.email, required this.name})
      : super(key: key);
  final String email;
  final String name;
  final dio = Dio()..interceptors.add(CustomLogInterceptor());

  @override
  Widget build(BuildContext context) {
    final restClient = RestClient(dio);
    //String picture = null;
    var userdata = {
      'email': email,
      'name': name,
      //'picture': picture,
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
            }
          }
          return paging(valid);
        },
      )),
    );
  }

  Widget paging(bool valid) {
    if (valid) {
      return const Homey();
    } else {
      return const SignUp();
    }
  }
}
