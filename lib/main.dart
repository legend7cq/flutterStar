import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
      // title: 'Welcome to Flutter',
      // home: new Scaffold(
      //   appBar: new AppBar(
      //     title: new Text('Welcome to Flutter'),
      //   ),
      //   body: new Center(
      //     // child: new Text(wordPair.asPascalCase),
      //     child: new RandomWords(),
      //   ),
      // ),

      title: 'Startup Name Generator1',
      home: new RandomWords(),
      theme: new ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.deepPurpleAccent,
        )
      ),
    );
  }
}

class RandomWords extends StatefulWidget {

  @override
  State createState() => new RandomWordState();
}


class RandomWordState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  void _pushSaved(){
      Navigator.of(context).push(
        new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );

        },
      ),
      );
  }
  Widget _buildRow(WordPair pair){
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(pair.asPascalCase,
        style: _biggerFont,),
      trailing: new Icon(alreadySaved?Icons.favorite:Icons.favorite_border,color:  alreadySaved?Colors.red:null,),
      onTap: (){
        setState(() {
          if(alreadySaved) {
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget _buidSuggestions() {
    return new ListView.builder(itemBuilder: (context,i){
      if(i.isOdd) return new Divider();
      final index = i ~/2;
      if(index >=_suggestions.length){
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    });
  }

  @override
  Widget build(BuildContext context) {

  return new Scaffold(
    appBar: new AppBar(
      actions: <Widget>[new IconButton(onPressed: _pushSaved, icon: new Icon(Icons.list))],
      title: new Text('Startup Name Generator2'),),
    body: _buidSuggestions(),
  );

    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
  }
}












