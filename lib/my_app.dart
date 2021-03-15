import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import 'saved_words.dart';
import 'suggestions.dart';
import 'saved.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Suggestions>(
          create: (context) => Suggestions(),
        ),
        ChangeNotifierProvider<Saved>(
          create: (context) => Saved(),
        ),
      ],
      child: MaterialApp(
        title: 'Welcome to Flutter',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: RandomWords(),
      ),
    );
  }
}

class RandomWords extends StatelessWidget {
  final _biggerFont = TextStyle(fontSize: 18.0);

  void _addSuggestions(BuildContext context) {
    Provider.of<Suggestions>(context, listen: false).addSuggestions();
  }

  void _saveWordPair(BuildContext context, WordPair pair) {
    Provider.of<Saved>(context, listen: false).saveWordPairs(pair);
  }

  void _removeWordPair(BuildContext context, WordPair pair) {
    Provider.of<Saved>(context, listen: false).removeWordPairs(pair);
  }

  @override
  Widget build(BuildContext context) {
    var suggestions = Provider.of<Suggestions>(context).getSuggestions;
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SavedWords()));
            },
          ),
        ],
      ),
      body: _buildSuggestions(suggestions),
    );
  }

  Widget _buildSuggestions(suggestions) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          var saved = Provider.of<Saved>(context).getSaved;
          if (i.isOdd) {
            return Divider(); /*2*/
          }

          final index = i ~/ 2; /*3*/
          if (index >= suggestions.length) {
            _addSuggestions(context);
          }
          return _buildRow(suggestions[index], saved);
        });
  }

  Widget _buildRow(WordPair pair, saved) {
    var _alreadySaved = saved.contains(pair);
    return Builder(
      builder: (BuildContext context) => ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(
            _alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: _alreadySaved ? Colors.red : null,
          ),
          onTap: () {
            if (_alreadySaved) {
              _removeWordPair(context, pair);
            } else {
              _saveWordPair(context, pair);
            }
          }),
    );
  }
}
