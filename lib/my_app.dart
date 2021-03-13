import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import 'suggestions.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Suggestions>(
          create: (context) => Suggestions(),
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

  void _addSuggestions(BuildContext context) async {
    Provider.of<Suggestions>(context, listen: false).addSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    var suggestions = Provider.of<Suggestions>(context).getSuggestions;
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: () {}),
        ],
      ),
      body: _buildSuggestions(suggestions),
    );
  }

  Widget _buildSuggestions(suggestions) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) {
            return Divider(); /*2*/
          }

          final index = i ~/ 2; /*3*/
          if (index >= suggestions.length) {
            _addSuggestions(context);
          }
          return _buildRow(suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        Icons.favorite_border,
        color: null,
      ),
    );
  }
}
