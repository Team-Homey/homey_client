import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
    const name = 'Yurim';
    // email to json
    final jsonEmail = {'email': email, 'name': name};

    return Scaffold(
        appBar: AppBar(
          title: const Text('Dio'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: restClient.pingTest(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              }
              return const Text('No data');
            },
          ),
        ));
  }
}
