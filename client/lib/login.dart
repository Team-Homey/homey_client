import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app.dart';
import 'sign_up.dart';

// home_login()
class HomeyLogin extends StatelessWidget {
  const HomeyLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/Logo_White.svg',
                semanticsLabel: 'Loding screen',
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.fill),
            const SizedBox(height: 50),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.google,
              backgroundColor: Colors.blueAccent,
              disabledBackgroundColor: Colors.blueAccent.withOpacity(1),
              textColor: Colors.white,
              imageURL: 'assets/images/google.png',
              text: "Sign up with Google",
              width: 350,
              onPressed: () {
                bool valid = false;
                // final GoogleSignIn _googleSignIn = GoogleSignIn(
                //   scopes: <String>[
                //     'email',
                //     'https://www.googleapis.com/auth/contacts.readonly',
                //   ],
                // );
                //_googleSignIn.signIn();
                // if(valid) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const Homey()),
                //   );
                // }
                if (valid) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Homey()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
