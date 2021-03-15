import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Saved extends ChangeNotifier {
  var _saved = <WordPair>[];

  get getSaved {
    return _saved;
  }

  void saveWordPairs(WordPair pair) {
    _saved.add(pair);
    notifyListeners();
  }

  void removeWordPairs(WordPair pair) {
    _saved.remove(pair);
    notifyListeners();
  }
}
