import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import '../data/custom_log_interceptor.dart';
import '../data/rest_client.dart';

class ProfileShow extends StatefulWidget {
  const ProfileShow({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileShow> {
  late var _accessToken = '';
  late SharedPreferences _prefs;
  final dio = Dio()..interceptors.add(CustomLogInterceptor());
  User? user;

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
    // return Scaffold(
    //   body: Center(
    //       child: FutureBuilder<User?>(
    //     future: restClient.getMyInfo(token: 'Bearer $_accessToken'),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         user = snapshot.data;
    //         return Column(
    //           children: [
    //             // user profile image
    //             Container(
    //               child: CircularProfileAvatar(
    //                 '',
    //                 borderColor: const Color(0xFFFFC107),
    //                 borderWidth: 3,
    //                 elevation: 5,
    //                 radius: 38,
    //                 child: const Image(
    //                   image: AssetImage('assets/images/unknown.png'),
    //                 ),
    //               ),
    //             ),
    //             // user name
    //             Container(
    //               child: Text(
    //                 user!.name ?? "No name",
    //               ),
    //             ),
    //             // user email
    //             Container(
    //               child: Text(user!.email),
    //             ),
    //             // user family
    //           ],
    //         );
    //       }
    //       return Container(
    //         child: Text('profile error'),
    //       );
    //     },
    //   )),
    // );
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
                child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 50, left: 20),
                child: CircularProfileAvatar(
                  '',
                  borderColor: Colors.amber,
                  borderWidth: 3,
                  elevation: 5,
                  radius: 50,
                  child: const Image(
                    image: AssetImage('assets/images/unknown.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.amber, width: 2)),
                      child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textContainer('Name', 'John Doe').showText(),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              textContainer('Contact', '123456789').showText(),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              textContainer('Email', 'xxx.com').showText(),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              textContainer('birthday', '1111.11.11')
                                  .showText(),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              textContainer('birthday', '1111.11.11')
                                  .showText(),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              textContainer('birthday', '1111.11.11')
                                  .showText(),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              textContainer('birthday', '1111.11.11')
                                  .showText(),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                            ],
                          ))))
            ]))));
  }
}

class textContainer {
  String title;
  String content;
  textContainer(this.title, this.content);

  showText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFFFC107),
            fontSize: 12,
          ),
        ),
        Text(
          content,
          style: const TextStyle(
            color: Color.fromARGB(255, 60, 60, 60),
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
