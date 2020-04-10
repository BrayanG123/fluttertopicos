import 'package:flutter/material.dart';
import 'src/pages/home_page.dart';
import 'dart:async';

// Firebase
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: const FirebaseOptions(
      googleAppID : '1:920773967835:android:1789148c3c6bb22f7071fe',
      apiKey      : 'AIzaSyCXnX7hA7f8GVZ9GOPaK7-m2eG4SArrA1w',
      databaseURL : 'https://topicos-a8945.firebaseio.com/',
    ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Topicos Firebase',
    home: HomePage(app: app),
  ));
}

