import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        theme: _buildTheme(Brightness.dark),
        title: 'Namer App',
        home: MyHomePage(),
      ),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
  );
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if(favorites.contains(current)){
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

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


class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  Widget build(BuildContext context){
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override

  State<MyHomePage> createState() =>
  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  Widget build(BuildContext context) {
    Widget page;
    switch(selectedIndex){
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body:Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text("Home"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text("Favorites"),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value){
                setState(() {
                  selectedIndex = value;
                });
              }
            )
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            )
          )
        ]
      )
    );
  }
}

class FavoritesPage extends StatefulWidget {
  @override

  State<FavoritesPage> createState() =>
  _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  late Future<List<Favorite>> favorites = fetchFavorites();

  Future <List<Favorite>> fetchFavorites() async {
    final response = await http
        .get(Uri.parse("http://localhost:4000/api/favorites"));
    final List body = json.decode(response.body)["data"];
    return body.map((favorite) => Favorite.fromJson(favorite)).toList();
  }

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
              return Center(child: Text("No favorites yet"));
            }
          }
        )
      )
    );
  }
}

Widget buildFavorites(List<Favorite> favorites) {
  return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index){
        final favorite = favorites[index];
        return ListTile(
            leading: Icon(Icons.favorite),
            title: Text(favorite.wordpair),
          );
      }
    );
}

class GeneratorPage extends StatelessWidget {
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if(appState.favorites.contains(pair)){
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_outline;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: (){
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text("Like"),
              ),
              ElevatedButton(
                onPressed: (){
                  appState.getNext();
                },
                child: Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}