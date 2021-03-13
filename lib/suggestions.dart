import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Suggestions extends ChangeNotifier {
  var _suggestions = <WordPair>[];

  get getSuggestions {
    return _suggestions;
  }

  void addSuggestions() async {
    _suggestions.addAll(generateWordPairs().take(10));
  }
}
