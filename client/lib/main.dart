// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'google_login.dart';
import 'data/dio_result_page.dart';
import 'app.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // if login is successful, runApp(Homey())
  runApp(
    MaterialApp(title: 'Homey', home: GoogleLogin()),
    //MaterialApp(title: 'Homey', home: Homey()),
    //if already has token, runApp(Homey())
  );
  FlutterNativeSplash.remove();
}
