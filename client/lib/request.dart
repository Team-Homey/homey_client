import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Authentication {
  final String email;

  const Authentication({required this.email});

  factory Authentication.fromJson(Map<String, dynamic> json) {
    return Authentication(
      email: json['email'],
    );
  }
}

Future<Authentication> createAuth(String email) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/authentication/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Authentication.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create auth.');
  }
}

FutureBuilder<Authentication> buildFutureBuilder(
    Future<Authentication>? futureAuth) {
  return FutureBuilder<Authentication>(
    future: futureAuth,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Text(snapshot.data!.email);
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }

      return const CircularProgressIndicator();
    },
  );
}
