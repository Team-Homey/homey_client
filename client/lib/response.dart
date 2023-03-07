import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  var url = Uri.https('34.64.211.177', '', {'q': '{http}'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    print('Number of books about http: $itemCount.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
