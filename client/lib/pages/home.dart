import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../data/rest_client.dart';
import '../data/custom_log_interceptor.dart';

String token = '';
void getToken() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    token = pref.getString('accessToken')!;
  } catch (e) {}
}

Widget homeScreenShow() {
  getToken();

  return Container();
}

class DioResultPage extends StatelessWidget {
  DioResultPage({Key? key}) : super(key: key);
  final dio = Dio()
    ..interceptors.add(
      CustomLogInterceptor(),
    );

  @override
  Widget build(BuildContext context) {
    final restClient = RestClient(dio);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dio'),
        ),
        body: Center(child: FutureBuilder<Data?>(
          //future: restClient.authentication(jsondata: jsonEmail),
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
