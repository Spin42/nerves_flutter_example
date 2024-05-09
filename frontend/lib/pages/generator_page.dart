import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../components/bigcard.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if(appState.currentIsFavorite){
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_outline;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: (){
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: const Text("Like"),
              ),
              ElevatedButton(
                onPressed: (){
                  appState.getNext();
                },
                child: const Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}