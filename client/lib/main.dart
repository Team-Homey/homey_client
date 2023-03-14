// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'google_login.dart';
import 'data/dio_result_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // if login is successful, runApp(Homey())
  runApp(
    MaterialApp(title: 'Homey', home: GoogleLogin()),
    //home: DioResultPage()),
  );
  FlutterNativeSplash.remove();
}
