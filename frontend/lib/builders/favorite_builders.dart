import 'package:flutter/material.dart';

import '../models/favorite.dart';

Widget buildFavorites(List<Favorite> favorites) {
  return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index){
        final favorite = favorites[index];
        return ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(favorite.wordpair),
          );
      }
    );
}