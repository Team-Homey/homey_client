import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../data/custom_log_interceptor.dart';
import '../data/rest_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _positionController;
  late AnimationController _shadowpositionController;
  late FlutterGifController _gifController;

  double _xOffset = 200.0;
  double _yOffset = 100.0;
  double _xShOffset = 200.0;
  double _yShOffset = 200.0;
  double _targetXOffset = 300.0;
  double _targetYOffset = 300.0;

  String _accessToken = '';
  FamilyInfo? family;

  @override
  void initState() {
    super.initState();
    loadData();

    _positionController = AnimationController(
        vsync: this, duration: const Duration(seconds: 200));
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

    _shadowpositionController = AnimationController(
        vsync: this, duration: const Duration(seconds: 200));
    _shadowpositionController.repeat();
    _shadowpositionController.addListener(() {
      setState(() {
        double animationValue = _shadowpositionController.value;
        _xShOffset = _targetXOffset * 0.8 * animationValue +
            _xShOffset * (1 - animationValue);
        _yShOffset = 180 +
            _targetYOffset * animationValue +
            _yShOffset * (1 - animationValue) * 0.5;
      });
    });

    _gifController =
        FlutterGifController(vsync: this, duration: const Duration(seconds: 1));
    _gifController.repeat(min: 0, max: 2, period: const Duration(seconds: 1));
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
        FamilyInfo? family =
            await restClient.getMyFamily(token: 'Bearer $_accessToken');
        setState(() {
          this.family = family;
        });
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  void dispose() {
    _positionController.dispose();
    _shadowpositionController.dispose();
    _gifController.dispose();
    super.dispose();
  }

  String getEmojiFromEmotionName(String? emotionName) {
    List<String> emotions = [
      '🥰',
      '😊',
      '🙂',
      '🤔',
      '😕',
      '😭',
      '😠',
    ];
    List<String> emotionsText = [
      'Lovely',
      'Happy',
      'Good',
      "Don't know",
      'So-So',
      'Sad',
      'Angry',
    ];
    if (emotionName == null) return "?";
    int index = emotionsText.indexOf(emotionName);
    if (index != -1) {
      return emotions[index];
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> familyProfile = [
      'assets/images/yurim.png',
      'assets/images/yohwan.png',
      'assets/images/taejin.png',
      'assets/images/seoyeon.png'
    ];

    List<User> familyMember = family?.users ?? [];

    // List<String> familyProfile = [];

    int me = 0;

    return Scaffold(
        body: GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          _targetXOffset = details.localPosition.dx;
          _targetYOffset = details.localPosition.dy;
        });
      },
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
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Center(
                      child: Column(
                    children: [
                      Image(
                        image:
                            const AssetImage('assets/images/honeyCombBar.png'),
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      Image(
                        image: const AssetImage('assets/images/honeyComb.png'),
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      Image(
                        image: const AssetImage('assets/images/combShadow.png'),
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: SfLinearGauge(
                          ranges: const [
                            LinearGaugeRange(
                              startValue: 0,
                              endValue: 100,
                              color: Color(0xFFE3FFFA),
                            ),
                          ],
                          markerPointers: [
                            LinearShapePointer(
                              value: family?.point.toDouble() ?? 10,
                              color: Colors.amber,
                              // circle
                              shapeType: LinearShapePointerType.circle,
                              position: LinearElementPosition.cross,
                            ),
                          ],
                          barPointers: [
                            LinearBarPointer(
                              value: family?.point.toDouble() ?? 10,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width *
                            0.2 *
                            familyMember.length,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: familyMember.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(children: [
                                    CircularProfileAvatar(
                                      '',
                                      borderColor: index == me
                                          ? const Color(0xFFFFC107)
                                          : Colors.white,
                                      borderWidth: 3,
                                      elevation: 5,
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.075,
                                      child: Image(
                                        image: AssetImage(familyProfile[index]),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: index == me
                                              ? const Color(0xFFFFC107)
                                              : Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          getEmojiFromEmotionName(
                                              familyMember[index].emotion),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    familyMember[index].name ?? '',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
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
                          image: const AssetImage("assets/images/bee.gif"),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: _xShOffset,
                    top: _yShOffset,
                    child: AnimatedBuilder(
                      animation: _shadowpositionController,
                      builder: (context, child) {
                        return const Image(
                          image: AssetImage('assets/images/beeShadow.png'),
                          width: 200,
                          height: 200,
                        );
                      },
                    ),
                  ),
                ])),
          ],
        )),
      ),
    ));
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
        Paint()..color = const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
      );
    }
  }

  @override
  bool shouldRepaint(TouchPositionPainter oldDelegate) {
    return oldDelegate.position != position || oldDelegate.showRing;
  }
}
