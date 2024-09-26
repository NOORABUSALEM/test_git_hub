import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SecondScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String _savedText = '';

  @override
  void initState() {
    super.initState();
    _loadSavedText();  // Load the saved text when the screen is initialized
  }

  // Method to load saved text from SharedPreferences
  Future<void> _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText = prefs.getString('savedText') ?? '';  // Default to empty if no text is saved
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Saved Text:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              _savedText.isEmpty ? 'No data yet' : _savedText,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondScreen()),
                ).then((_) {
                  _loadSavedText();  // Refresh the screen to load the new saved text
                });
              },
              child: Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
