import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  bool isFirebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        isFirebaseInitialized = true;
      });
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Connection Test'),
        ),
        body: Center(
          child: isFirebaseInitialized
              ? const Text('Firebase connection successful!')
              : const Text('Initializing Firebase...'),
        ),
      ),
    );
  }
}
