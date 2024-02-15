import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'models/character_class.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const CharacterPage(title: 'Rick and Morty Card'),
    );
  }
}

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key, required this.title});

  final String title;

  @override
  State<CharacterPage> createState() => _Character();
}

class _Character extends State<CharacterPage> {
  CharacterClass? _currentCharacter;

  Future<CharacterClass> getNewCharacter() async {
    int randomId = 1 + Random().nextInt(826);
    var url = Uri.https(
        'rickandmortyapi.com', '/api/character/$randomId', {'q': '{http}'});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('Character name is: ${_currentCharacter.name}.');
      setState(() {
        _currentCharacter =
            CharacterClass.fromJson(convert.jsonDecode(response.body));
      });
      return CharacterClass.fromJson(convert.jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return CharacterClass(
        id: 0,
        name: 'Error',
        status: 'Error',
        species: 'Error',
        type: 'Error',
        gender: 'Error',
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getNewCharacter().then((value) {
      setState(() {
        _currentCharacter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              _currentCharacter.image as String,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Text('ð¢');
              },
            ),
            Text(
              'Character name is: ${_currentCharacter.name}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: getNewCharacter,
              child: const Text('Get New Character'),
            ),
          ],
        ),
      ),
    );
  }
}
