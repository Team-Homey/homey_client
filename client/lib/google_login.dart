import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import 'login.dart';

class GoogleLogin extends StatelessWidget {
  GoogleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image(
            image: const AssetImage('assets/images/Logo_White.png'),
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(height: 50),
          SocialLoginButton(
              buttonType: SocialLoginButtonType.google,
              backgroundColor: Colors.blueAccent,
              disabledBackgroundColor: Colors.blueAccent.withOpacity(1),
              textColor: Colors.white,
              text: "Sign up with Google",
              width: 350,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeyLogin(email: 'user1', name: 'user1')),
                );
              })
        ])));
  }
}
