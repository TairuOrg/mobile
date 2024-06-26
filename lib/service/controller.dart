import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getSale() async {
  final response = await http.get(Uri.parse(env(BASE_URL) + '/sale'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data.
    final data = jsonDecode(response.body);
    print('Data fetched: $data');
  } else {
    // If the server returns an error response, throw an exception.
    throw Exception('Failed to load data');
  }
}
