import 'package:flutter/material.dart';

class LoveNotesScreen extends StatefulWidget {
  const LoveNotesScreen({super.key});

  @override
  State<LoveNotesScreen> createState() => _LoveNotesScreenState();
}

class _LoveNotesScreenState extends State<LoveNotesScreen> {
  final List<String> _reasons = [
    "I love your smile that lights up the room.",
    "You are my best friend and my soulmate.",
    "The way you laugh at my silly jokes.",
    "Your kindness towards everyone you meet.",
    "How you make our house feel like a home.",
    "Your unwavering support in everything I do.",
    "The way you look at me.",
    "Your delicious cooking!",
    "How you always know what to say.",
    "Just being you.",
  ];

  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Why I Love You'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _reasons.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildNoteCard(index);
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${_currentPage + 1} of ${_reasons.length}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // In a real app, this would open a dialog to add a new note
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feature to add new notes coming soon!')),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add New Note'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 400,
            width: Curves.easeOut.transform(value) * 300,
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 8,
        color: Colors.pink[50],
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite, size: 60, color: Colors.red),
              const SizedBox(height: 24),
              Text(
                _reasons[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Georgia',
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '- Your Husband',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
