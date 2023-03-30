import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'family/set_family.dart';
import '../data/rest_client.dart';
import '../data/custom_log_interceptor.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  String contact = '';
  String birthday = '';
  String sex = '';
  String role = '';
  String address = '';
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
        title: 'Sign Up',
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
            title: const Text('Sign Up', style: TextStyle(color: Colors.white)),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(children: [
                // Contact, Birthday, Sex, Role in your family, Address
                const SizedBox(height: 50),
                SvgPicture.asset('assets/images/Logo_White.svg',
                    semanticsLabel: 'Loding screen',
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.fill),
                const SizedBox(height: 30),
                renderTextFormField(
                  label: 'Contact',
                  onSaved: (val) {
                    setState(() {
                      contact = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '연락처를 입력해주세요!';
                    }
                    return null;
                  },
                ),
                renderTextFormField(
                  label: 'Birthday',
                  onSaved: (val) {
                    setState(() {
                      birthday = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '생일을 입력해주세요!';
                    }
                    return null;
                  },
                ),
                renderTextFormField(
                  label: 'Sex',
                  onSaved: (val) {
                    setState(() {
                      sex = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '성별을 입력해주세요!';
                    }
                    return null;
                  },
                ),
                renderTextFormField(
                  label: 'Role in your family',
                  onSaved: (val) {
                    setState(() {
                      role = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '가족 내에서의 역할을 입력해주세요!';
                    }
                    return null;
                  },
                ),
                renderTextFormField(
                  label: 'Address',
                  onSaved: (val) {
                    setState(() {
                      address = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '주소를 입력해주세요!';
                    }
                    return null;
                  },
                ),
                renderButton(),
                const SizedBox(height: 70),
              ]),
            ),
          ),
        ),
      ),
    );
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
      ),
      onPressed: () {
        if (formKey.currentState == null) {
          print("formKey.currentState is null");
        } else if (formKey.currentState!.validate()) {
          formKey.currentState!.save();

          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Sign Up'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Sign Up Success!'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      // request to server user info
                      final dio = Dio()
                        ..interceptors.add(CustomLogInterceptor());
                      final restClient = RestClient(dio);
                      var jsondata = {
                        'age': 20,
                        'gender': sex,
                        'address': address,
                        'picture': 'https://i.imgur.com/BoN9kdC.png',
                        'birth': birthday,
                        'familyRole': role,
                      };

                      if (_accessToken != '') {
                        restClient.updateMyInfo(
                            token: 'Bearer $_accessToken', jsondata: jsondata);
                      } else {}

                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SetFamily()),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: const Text(
        'Save',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
