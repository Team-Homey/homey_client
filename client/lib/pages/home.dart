import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_gif/flutter_gif.dart';

import '../data/custom_log_interceptor.dart';
import '../data/rest_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _positionController;
  late Animation<Offset> _animation;
  late var _accessToken = '';
  late SharedPreferences _prefs;
  late FlutterGifController _gifController;

  final dio = Dio()..interceptors.add(CustomLogInterceptor());
  double _xOffset = 200.0;
  double _yOffset = 100.0;
  double _targetXOffset = 300.0;
  double _targetYOffset = 300.0;
  double _ringSize = 0.0;
  bool _showRing = false;

  @override
  void initState() {
    super.initState();
    _positionController =
        AnimationController(vsync: this, duration: Duration(seconds: 200));
    _positionController.repeat();
    _positionController.addListener(() {
      setState(() {
        double animationValue = _positionController.value;
        _xOffset = _targetXOffset * 0.8 * animationValue +
            _xOffset * (1 - animationValue);
        _yOffset = _targetYOffset * 0.8 * animationValue +
            _yOffset * (1 - animationValue);
      });
    });
    _gifController =
        FlutterGifController(vsync: this, duration: const Duration(seconds: 1));
    _gifController.repeat(min: 0, max: 2, period: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _positionController.dispose();
    _gifController.dispose();
    super.dispose();
  }

  // _loadToken() async {
  //   final restClient = RestClient(dio);
  //   _prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _accessToken = _prefs.getString('accessToken') ?? '';
  //   });
  //   FutureBuilder<String?>(
  //     future: restClient.getMyFamilyString(token: 'Bearer $_accessToken'),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         String? fmaily = snapshot.data;
  //         return Text('$fmaily');
  //       }
  //       return const Text('Family error1');
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    List<String> family_member = ["Yurim", "Yohwan", "Taejin", "Seoyeon"];
    int me = 0;

    return Scaffold(
        body: GestureDetector(
            onTapDown: (TapDownDetails details) {
              setState(() {
                _targetXOffset = details.localPosition.dx;
                _targetYOffset = details.localPosition.dy;
              });
              // when onTap, touch color change
            },
            child: CustomPaint(
              painter: TouchPositionPainter(
                position: Offset(_xOffset, _yOffset),
                showRing: _showRing,
                ringSize: _ringSize,
              ),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE3FFFA),
                    Color(0xFFFFFFFF),
                  ],
                )),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.68,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(children: [
                          Center(
                              child: Column(
                            children: [
                              Image(
                                image: const AssetImage(
                                    'assets/images/honeyCombBar.png'),
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Image(
                                image: const AssetImage(
                                    'assets/images/honeyComb.png'),
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                            ],
                          )),
                          Positioned(
                            left: _xOffset,
                            top: _yOffset,
                            child: AnimatedBuilder(
                              animation: _positionController,
                              builder: (context, child) {
                                return GifImage(
                                  width: 150,
                                  height: 150,
                                  controller: _gifController,
                                  image:
                                      const AssetImage("assets/images/bee.gif"),
                                );
                              },
                            ),
                          ),
                        ])),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: family_member.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Stack(children: [
                                  CircularProfileAvatar(
                                    '',
                                    borderColor: index == me
                                        ? const Color(0xFFFFC107)
                                        : Colors.white,
                                    borderWidth: 3,
                                    elevation: 5,
                                    radius: 38,
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/unknown.png'),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ]),
                                Text(family_member[index]),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )),
              ),
            )));
  }
}

class TouchPositionPainter extends CustomPainter {
  final Offset position;
  final bool showRing;
  final double ringSize;

  TouchPositionPainter({
    required this.position,
    required this.showRing,
    required this.ringSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (showRing) {
      canvas.drawCircle(
        position,
        ringSize / 2,
        Paint()..color = Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
      );
    }
  }

  @override
  bool shouldRepaint(TouchPositionPainter oldDelegate) {
    return oldDelegate.position != position || oldDelegate.showRing;
  }
}
