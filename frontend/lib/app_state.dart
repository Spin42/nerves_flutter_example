import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import './services/favorite_services.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  var currentIsFavorite = false;

  Future<void> getNext() async {
    current = WordPair.random();
    setFavoriteStatus().then((value) =>
      notifyListeners()
    );
  }

  void toggleFavorite() {
    createOrDeleteFavorite(current.asLowerCase).then((value) => {
      setFavoriteStatus().then((value) =>
        notifyListeners()
      ),
    });
  }

  Future<void> setFavoriteStatus() async {
    try {
      await getFavorite(current.asLowerCase).then(
        (favorite) => {
          currentIsFavorite = true
        }
      );
    } catch (_) {
      currentIsFavorite = false;
    }
  }
}