import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import '../data/rest_client.dart';
import '../data/custom_log_interceptor.dart';
import '../app.dart';

class BuildNewFamily extends StatefulWidget {
  const BuildNewFamily({Key? key}) : super(key: key);

  @override
  BuildNewFamilyState createState() => BuildNewFamilyState();
}

class BuildNewFamilyState extends State<BuildNewFamily> {
  final formKey = GlobalKey<FormState>();

  String familyName = '';
  String _accessToken = '';

  final dio = Dio()..interceptors.add(CustomLogInterceptor());

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = prefs.getString('accessToken') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: MaterialApp(
          title: 'Build New Family',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: Scaffold(
            backgroundColor: Colors.white,
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
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  renderTextFormField(
                    label: 'family name',
                    onSaved: (val) {
                      setState(() {
                        familyName = val;
                      });
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter some text!';
                      }
                      return null;
                    },
                  ),
                  renderButton(),
                ],
              )),
            ),
          ),
        ));
  }

  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 12.0,
                      color: Colors.amber),
                ),
              ],
            ),
            TextFormField(
              style: const TextStyle(
                  fontFamily: 'roboto',
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 104, 104, 104)),
              onSaved: onSaved,
              validator: validator,
              autovalidateMode: AutovalidateMode.always,
            ),
            Container(
              height: 50,
            ),
          ],
        ));
  }

  renderButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.amber,
          disabledForegroundColor: const Color.fromARGB(255, 24, 24, 24),
          minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
              MediaQuery.of(context).size.height * 0.07)),
      onPressed: () {
        if (formKey.currentState == null) {
          print("formKey.currentState is null");
        } else if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          final dio = Dio()..interceptors.add(CustomLogInterceptor());
          final restClient = RestClient(dio);
          String? familyCode;
          var jsondata = {
            'name': familyName,
          };

          if (_accessToken != '') {
            var fmaily = restClient.createFamily(
                token: 'Bearer $_accessToken', jsondata: jsondata);
            // get fmaily code
            fmaily.then((value) {
              familyCode = value.code;
              print('familyCode: $familyCode');
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Sign Up'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          const Text('Make family Success! Family Code is'),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.end,
                            children: [
                              Text('$familyCode',
                                  style: const TextStyle(color: Colors.grey)),
                              FloatingActionButton(
                                  mini: true,
                                  backgroundColor: Colors.white,
                                  child: const Icon(Icons.content_copy,
                                      size: 20, color: Colors.grey),
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: familyCode));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Copied to Clipboard')));
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK',
                            style: TextStyle(color: Colors.amber)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homey()),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            });
          } else {
            print('token is null');
          }
        }
      },
      child: const Text(
        'Build Family',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
