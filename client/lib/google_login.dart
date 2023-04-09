import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import 'login.dart';

class GoogleLogin extends StatelessWidget {
  GoogleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = '';
    String name = '';
    final formKey = GlobalKey<FormState>();
    return MaterialApp(
        title: 'Homey',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image(
                    image: const AssetImage('assets/images/Logo_White.png'),
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Form(
                      key: formKey,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                email = String.fromCharCodes(value!.codeUnits);
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                name = String.fromCharCodes(value!.codeUnits);
                              },
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(Size(
                                        MediaQuery.of(context).size.width * 0.8,
                                        MediaQuery.of(context).size.height *
                                            0.08))),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeyLogin(
                                              email: email, name: name)),
                                    );
                                  }
                                },
                                child: const Text('Sign up with Email',
                                    style: TextStyle(color: Colors.white)))
                          ]))),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                      const Text('  or  '),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SocialLoginButton(
                      buttonType: SocialLoginButtonType.google,
                      backgroundColor: Colors.white,
                      borderRadius: BorderSide.strokeAlignCenter,
                      textColor: Colors.black,
                      text: "Sign up with Google",
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.08,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeyLogin(
                                  email: 'yurim@gmail.com', name: 'Yurim')),
                        );
                      }),
                  const SizedBox(height: 20),
                ]))));
  }
}
