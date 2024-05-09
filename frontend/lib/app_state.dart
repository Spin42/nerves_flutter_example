import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import './services/favorite_services.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    createOrDeleteFavorite(current.asLowerCase);
    notifyListeners();
  }
}