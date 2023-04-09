// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'google_login.dart';
import 'app.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // if has token, go to home page
  bool hasToken = false;
  () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;
    if (accessToken != null) {
      hasToken = true;
    }
  };
  runApp(MaterialApp(
      title: 'Homey',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: hasToken ? Homey() : GoogleLogin()));
  FlutterNativeSplash.remove();
}
