import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'footer.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    

    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          Text(appState.current.asLowerCase),
          ElevatedButton(
            onPressed: () async {
              print('button pressed!');
              await FirebaseFirestore.instance
                .collection('test_table')
                .doc('test_doc')
                .set({
                  'id': '1',
                  'num': 4,
                  'str': "test",
                  'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
                });
            },
            child: Text('Next'),
          ),
        ],
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
