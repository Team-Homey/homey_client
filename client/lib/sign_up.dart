import 'package:flutter/material.dart';
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

  String birthday = '';
  String sex = '';
  String role = '';
  String name = '';
  String address = '';
  String _accessToken = '';

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
                Image(
                  image: const AssetImage('assets/images/Logo_White.png'),
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: 30),
                renderTextFormField(
                  label: 'Name',
                  onSaved: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter your name!';
                    }
                    return null;
                  },
                ),
                renderTextFormField(
                  label: 'Birthday [YYYY-MM-DD]',
                  onSaved: (val) {
                    setState(() {
                      birthday = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter your birthday!';
                    } else if (DateTime.tryParse(val) == null) {
                      return 'Invalid birthday!';
                    }
                    return null;
                  },
                ),
                renderButtonFormField(
                    label: 'Sex',
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          sex = val;
                        });
                      } else {
                        setState(() {
                          val = val;
                        });
                      }
                    },
                    items: [null, 'Male', 'Female']
                        .map<DropdownMenuItem<String?>>((String? i) {
                      return DropdownMenuItem<String?>(
                          value: i,
                          child: Text({'Male': 'Male', 'Female': 'Female'}[i] ??
                              'Unknown'));
                    }).toList(),
                    validator: (val) {
                      if (val == null) {
                        return 'Enter your sex!';
                      }
                      return null;
                    }),
                renderButtonFormField(
                    label: 'Role in your family',
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          role = val;
                        });
                      } else {
                        setState(() {
                          role = val;
                        });
                      }
                    },
                    items: [
                      null,
                      'FAMILY_ROLE_FATHER',
                      'FAMILY_ROLE_MOTHER',
                      'FAMILY_ROLE_PARENT',
                      'FAMILY_ROLE_SON',
                      'FAMILY_ROLE_DAUGHTER',
                      'FAMILY_ROLE_CHILD',
                      'FAMILY_ROLE_GRANDPARENT'
                    ].map<DropdownMenuItem<String?>>((String? i) {
                      return DropdownMenuItem<String?>(
                          value: i,
                          child: Text({
                                'FAMILY_ROLE_FATHER': 'Father',
                                'FAMILY_ROLE_MOTHER': 'Mother',
                                'FAMILY_ROLE_PARENT': 'Parent',
                                'FAMILY_ROLE_SON': 'Son',
                                'FAMILY_ROLE_DAUGHTER': 'Daughter',
                                'FAMILY_ROLE_CHILD': 'Child',
                                'FAMILY_ROLE_GRANDPARENT': 'Grand Parent',
                              }[i] ??
                              'Unknown'));
                    }).toList(),
                    validator: (val) {
                      if (val == null) {
                        return 'Enter your sex!';
                      }
                      return null;
                    }),

                renderTextFormField(
                  label: 'Address',
                  onSaved: (val) {
                    setState(() {
                      address = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter your address!';
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

  renderButtonFormField({
    required String label,
    required List<DropdownMenuItem> items,
    required FormFieldSetter onChanged,
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
            DropdownButtonFormField(
              items: items,
              onChanged: onChanged,
              validator: validator,
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
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.7,
            MediaQuery.of(context).size.height * 0.05,
          ),
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
                        final dio = Dio()
                          ..interceptors.add(CustomLogInterceptor());
                        final restClient = RestClient(dio);
                        var jsondata = {
                          'age': 20,
                          'gender': sex,
                          'name': name,
                          'address': address,
                          'birth': birthday,
                          'familyRole': role,
                        };

                        if (_accessToken != '') {
                          restClient.updateMyInfo(
                              token: 'Bearer $_accessToken',
                              jsondata: jsondata);
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
        ));
  }
}
