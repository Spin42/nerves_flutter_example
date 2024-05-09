class Favorite {
  final int id;
  final String wordpair;

  const Favorite({
    required this.id,
    required this.wordpair,
  });

  factory Favorite.fromJson(Map<String, dynamic> json){
    return switch(json){
      {
        'id': int id,
        'wordpair': String wordpair
      } =>
        Favorite(
          id: id,
          wordpair: wordpair
        ),
        _ => throw const FormatException("Failed to load favorite")
    };
  }
}