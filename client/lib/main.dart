// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'login.dart';
import 'request.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // if login is successful, runApp(Homey())
  runApp(
    const MaterialApp(
      title: 'Homey',
      home: HomeyLogin(),
    ),
  );
  FlutterNativeSplash.remove();
}
