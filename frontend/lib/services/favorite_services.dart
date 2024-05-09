import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/favorite.dart';

const apiUrl = "http://localhost:4000/api";

Future <List<Favorite>> fetchFavorites() async {
  final response = await http.get(
    Uri.parse("$apiUrl/favorites")
  );
  if(response.statusCode == 200) {
    final List body = json.decode(response.body)["data"];
    return body.map((favorite) => Favorite.fromJson(favorite)).toList();
  } else {
    throw Exception("Failed to fetch Favorites.");
  }
}

Future <Favorite> createOrDeleteFavorite(String wordpair) async {
  final response = await http.post(
    Uri.parse('$apiUrl/favorites'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'wordpair': wordpair,
    }),
  );
  if (response.statusCode == 201 || response.statusCode == 202) {
    return Favorite.fromJson(jsonDecode(response.body)["data"] as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create Favorite.');
  }
}