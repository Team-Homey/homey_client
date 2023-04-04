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
  String _accessToken = '';
  User? user;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;
    if (accessToken != null) {
      setState(() {
        _accessToken = accessToken;
      });
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = RestClient(dio);
        User? user = await restClient.getMyInfo(token: 'Bearer $_accessToken');
        setState(() {
          this.user = user;
        });
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    image: AssetImage('assets/images/yurim.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.amber, width: 2)),
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextContainer('Name', user?.name).showText(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              TextContainer('Email', user?.email).showText(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              TextContainer('Birthday', user?.birth).showText(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              TextContainer('Sex', user?.gender).showText(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              TextContainer('Role', user?.familyRole)
                                  .showText(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              TextContainer('Address', user?.address)
                                  .showText(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Divider(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      thickness: 0.6)),
                              const SizedBox(height: 10),
                              // user?.regDate to form date

                              TextContainer('registration date',
                                      user?.regDate?.split('T')[0])
                                  .showText(),

                              SizedBox(
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

class TextContainer {
  String title;
  String? content;
  TextContainer(this.title, this.content);

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
          content ?? 'Unknown',
          style: const TextStyle(
            color: Color.fromARGB(255, 60, 60, 60),
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
