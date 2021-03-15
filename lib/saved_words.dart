import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import 'saved.dart';

class SavedWords extends StatelessWidget {
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    final _saved = Provider.of<Saved>(context).getSaved;
    final tiles = _saved.map<Widget>((WordPair pair) {
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      );
    });
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: divided.length > 0
          ? ListView(children: divided)
          : Center(
              child: Text('There is no saved item.'),
            ),
    );
  }
}
