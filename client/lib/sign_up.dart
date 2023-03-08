import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'app.dart';
import 'request.dart';
import 'response.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  String name = '';
  String contact = '';
  String email = '';
  String birthday = '';
  String sex = '';
  String role = '';
  String address = '';

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
                // Name, Contact, E-mail, Birthday, Sex, Role in your family, Address
                const SizedBox(height: 50),
                SvgPicture.asset('assets/images/Logo_White.svg',
                    semanticsLabel: 'Loding screen',
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.fill),
                const SizedBox(height: 30),
                renderTextFormField(
                  label: 'Name',
                  onSaved: (val) {
                    setState(() {
                      name = val!;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '이름을 입력해주세요!';
                    }
                    return null;
                  },
                ),
                renderTextFormField(
                  label: 'E-mail',
                  onSaved: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '이메일을 입력해주세요!';
                    }
                    return null;
                  },
                ),
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
          //print("formKey.currentState is null");
        } else if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          print("email: $email");
          Future<Authentication>? futureAuth;
          setState(() {
            futureAuth = createAuth(email);
          });
          buildFutureBuilder(futureAuth);
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
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Homey()),
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
