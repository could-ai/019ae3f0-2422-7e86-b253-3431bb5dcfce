import 'package:flutter/material.dart';
import 'dart:math';

class DateNightScreen extends StatefulWidget {
  const DateNightScreen({super.key});

  @override
  State<DateNightScreen> createState() => _DateNightScreenState();
}

class _DateNightScreenState extends State<DateNightScreen> {
  final List<String> _ideas = [
    "Candlelight Dinner at Home",
    "Movie Night with Popcorn",
    "Stargazing in the Backyard",
    "Cook a New Recipe Together",
    "Go for a Long Walk in the Park",
    "Board Game Marathon",
    "Visit a Museum",
    "Picnic at the Beach",
    "Karaoke Night",
    "Couples Massage",
    "Wine Tasting",
    "Build a Fort in the Living Room",
  ];

  String? _currentIdea;
  bool _isSpinning = false;

  void _spinWheel() async {
    setState(() {
      _isSpinning = true;
      _currentIdea = "Deciding...";
    });

    // Simulate spinning delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _currentIdea = _ideas[Random().nextInt(_ideas.length)];
      _isSpinning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Night Decider'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_dining, size: 100, color: Colors.orange),
            const SizedBox(height: 40),
            Text(
              'What should we do tonight?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: Text(
                _currentIdea ?? "Tap the button to decide!",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _isSpinning ? null : _spinWheel,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: Text(_isSpinning ? 'Spinning...' : 'Pick a Date!'),
            ),
          ],
        ),
      ),
    );
  }
}
