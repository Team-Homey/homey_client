import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/rest_client.dart';
import '../data/custom_log_interceptor.dart';
import '../app.dart';

class JoinFamily extends StatefulWidget {
  const JoinFamily({Key? key}) : super(key: key);

  @override
  JoinFamilyState createState() => JoinFamilyState();
}

class JoinFamilyState extends State<JoinFamily> {
  String _accessToken = '';
  String familyCode = '';
  Map<String, dynamic> jsontoken = {};
  Map<String, dynamic> jsondata = {};

  late SharedPreferences _prefs;
  final dio = Dio()..interceptors.add(CustomLogInterceptor());
  final prefs = SharedPreferences.getInstance();

  bool flag = false;
  String buttonText = '';

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
    final formKey = GlobalKey<FormState>();

    return MaterialApp(
        title: 'Join Family',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Join Family',
                  style: TextStyle(color: Colors.white)),
            ),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                        key: formKey,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'enter family code',
                            ),
                            onSaved: (value) {
                              familyCode =
                                  String.fromCharCodes(value!.codeUnits);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Join Family'),
                                      content: const Text(
                                          'You have successfully joined the family!'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Homey()));
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            jsondata = {
                              'hashCode': familyCode,
                            };

                            await restClient.joinFamily(
                                token: 'Bearer $_accessToken',
                                jsondata: jsondata);

                            setState(() {
                              flag = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.8, 50),
                          backgroundColor: flag ? Colors.amber : Colors.grey,
                        ),
                        child: const Text(
                          'Join Family',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    // make widget if flag is true, show dialog
                  ]),
            )));
  }
}
