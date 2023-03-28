import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/rest_client.dart';
import '../data/custom_log_interceptor.dart';
import '../app.dart';

class BuildNewFamily extends StatefulWidget {
  const BuildNewFamily({Key? key}) : super(key: key);

  @override
  BuildNewFamilyState createState() => BuildNewFamilyState();
}

class BuildNewFamilyState extends State<BuildNewFamily> {
  String _accessToken = '';
  String _refreshToken = '';
  String familyName = '';
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
      _refreshToken = _prefs.getString('refreshToken') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final restClient = RestClient(dio);
    final _formKey = GlobalKey<FormState>();

    return MaterialApp(
        title: 'Build New Family',
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
              title: const Text('Build New Family',
                  style: TextStyle(color: Colors.white)),
            ),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // fmaily name input
                    Form(
                        key: _formKey,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Family Name',
                            ),
                            onSaved: (value) {
                              familyName =
                                  String.fromCharCodes(value!.codeUnits);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else {
                                flag = true;
                              }
                              return null;
                            },
                          ),
                        )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            jsondata = {
                              'name': familyName,
                            };

                            await restClient.createFamily(
                                token: 'Bearer $_accessToken',
                                jsondata: jsondata);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.8, 50),
                          backgroundColor: flag ? Colors.amber : Colors.grey,
                        ),
                        child: const Text(
                          'Build New Family',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),

                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Homey()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.8, 50),
                          backgroundColor: flag ? Colors.amber : Colors.grey,
                        ),
                        child: const Text(
                          'Go to Homey',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ]),
            )));
  }
}
