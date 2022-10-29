// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const OnlinePharmacyAssignment());
}

class OnlinePharmacyAssignment extends StatelessWidget {
  const OnlinePharmacyAssignment({super.key});

  @override
  Widget build(BuildContext context) {
//    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Ramya',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Online Pharmacy Assignment'),
        ),
        //   body: const Center(
        //     child: Text('Hello Ramya'),
        //   ),
        body: const Center(
          //  child: Text(wordPair.asPascalCase),
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});
  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // @override
  // Widget build(BuildContext context) {
  //   final wordPair = WordPair.random();
  //   return Text(wordPair.asPascalCase);
  // }
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>{};
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return const Divider(
              thickness: 1.5,
            );
          }
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(50));
          }
          final alreadysaved = _saved.contains(_suggestions[index]);
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadysaved ? Icons.favorite : Icons.favorite_border,
              color: alreadysaved ? Colors.red : null,
              semanticLabel: alreadysaved ? 'Remove from Saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadysaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
        });
  }
}
