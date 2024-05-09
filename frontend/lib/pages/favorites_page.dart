import 'package:flutter/material.dart';
import '../builders/favorite_builders.dart';
import '../models/favorite.dart';
import '../services/favorite_services.dart';

class FavoritesPage extends StatefulWidget {
  @override

  State<FavoritesPage> createState() =>
  _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  late Future<List<Favorite>> favorites = fetchFavorites();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Favorite>>(
          future: favorites,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final finalfavorites = snapshot.data!;
              return buildFavorites(finalfavorites);
            } else {
              return const Text("No favorites yet");
            }
          }
        )
      )
    );
  }
}