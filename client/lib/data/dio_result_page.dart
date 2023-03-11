import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'custom_log_interceptor.dart';
import 'data.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio'),
      ),
      body: Center(
        // child: FutureBuilder<User?>(
        //   future: restClient.getUser(id: 1),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       User? userInfo = snapshot.data;
        //       if (userInfo != null) {
        //         Data userData = userInfo.data;
        //         return Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Image.network(userData.avatar),
        //             const SizedBox(height: 16.0),
        //             Text(
        //               '${userInfo.data.firstName} ${userInfo.data.lastName}',
        //               style: const TextStyle(fontSize: 24.0),
        //             ),
        //             Text(
        //               userData.email,
        //               style: const TextStyle(fontSize: 24.0),
        //             ),
        //           ],
        //         );
        //       }
        //     }
        //     return const CircularProgressIndicator();
        //   },
        // ),
        child: FutureBuilder<String?>(
          future: restClient.ping_test(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String? pingResult = snapshot.data;
              if (pingResult != null) {
                return Text(
                  pingResult,
                  style: const TextStyle(fontSize: 24.0),
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
