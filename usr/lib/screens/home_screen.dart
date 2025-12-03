import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> features = const [
    {'icon': Icons.favorite, 'title': 'Love Notes', 'route': '/love_notes', 'color': Colors.red},
    {'icon': Icons.photo_album, 'title': 'Our Memories', 'route': '/gallery', 'color': Colors.blue},
    {'icon': Icons.local_dining, 'title': 'Date Night', 'route': '/date_night', 'color': Colors.orange},
    {'icon': Icons.calendar_today, 'title': 'Special Dates', 'route': '/special_dates', 'color': Colors.purple},
    {'icon': Icons.chat_bubble, 'title': 'Our Chat', 'route': '/chat', 'color': Colors.teal},
    {'icon': Icons.card_giftcard, 'title': 'Wishlist', 'route': '/wishlist', 'color': Colors.pink},
    {'icon': Icons.wb_sunny, 'title': 'Affirmations', 'route': '/affirmations', 'color': Colors.amber},
    {'icon': Icons.music_note, 'title': 'Our Songs', 'route': '/music', 'color': Colors.deepPurple},
    {'icon': Icons.cloud, 'title': 'Weather', 'route': '/weather', 'color': Colors.lightBlue},
    {'icon': Icons.location_on, 'title': 'Find Me', 'route': '/location', 'color': Colors.green},
    {'icon': Icons.sos, 'title': 'Emergency', 'route': '/emergency', 'color': Colors.redAccent},
    {'icon': Icons.restaurant_menu, 'title': 'Recipes', 'route': '/recipes', 'color': Colors.brown},
    {'icon': Icons.attach_money, 'title': 'Budget', 'route': '/budget', 'color': Colors.greenAccent},
    {'icon': Icons.games, 'title': 'Games', 'route': '/games', 'color': Colors.indigo},
    {'icon': Icons.mood, 'title': 'Mood Check', 'route': '/mood', 'color': Colors.yellow},
    {'icon': Icons.book, 'title': 'Journal', 'route': '/journal', 'color': Colors.blueGrey},
    {'icon': Icons.flight, 'title': 'Travel Plans', 'route': '/travel', 'color': Colors.cyan},
    {'icon': Icons.check_circle, 'title': 'To-Do', 'route': '/todo', 'color': Colors.lime},
    {'icon': Icons.shopping_cart, 'title': 'Shopping', 'route': '/shopping', 'color': Colors.deepOrange},
    {'icon': Icons.settings, 'title': 'Settings', 'route': '/settings', 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('For My Beautiful Wife'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, My Love ❤️',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns for better visibility
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return _buildFeatureCard(context, feature);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, Map<String, dynamic> feature) {
    return InkWell(
      onTap: () {
        if (feature['route'] != null) {
          // Check if route is defined in main.dart, otherwise show placeholder
          try {
            Navigator.pushNamed(context, feature['route']);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${feature['title']} coming soon!')),
            );
          }
        }
      },
      child: Card(
        elevation: 2,
        shadowColor: feature['color'].withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: feature['color'].withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                feature['icon'],
                size: 32,
                color: feature['color'],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              feature['title'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
