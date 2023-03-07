import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import convert
import 'dart:convert' as convert;

String url = 'http://34.64.211.177/authentication/';

class info {
  final String email;
  info(
    this.email,
  );
  factory info.fromJson(Map<String, dynamic> json) {
    return info(
      json['email'],
    );
  }
}

Future<info> fetchInfo() async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    print(response.body);
    return info.fromJson(convert.jsonDecode(response.body));
  } else {
    throw Exception('Failed to load info');
  }
}
