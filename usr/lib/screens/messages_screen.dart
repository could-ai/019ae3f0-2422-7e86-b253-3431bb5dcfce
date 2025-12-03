import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:math';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _customMessageController = TextEditingController();
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  Timer? _messageOfTheDayTimer;
  String _messageOfTheDay = "Tap to get your daily message! ❤️";

  // Preloaded messages with romantic emojis
  final List<String> _goodMorningMessages = [
    "Good morning, my love! 🌅 You make every sunrise brighter. 😘",
    "Waking up to thoughts of you is the best way to start the day. 💕 Good morning!",
    "Rise and shine, beautiful! ☀️ Can't wait to see your smile today. 😍",
  ];

  final List<String> _goodNightMessages = [
    "Good night, my dearest. 🌙 Dream of us tonight. 💫",
    "Sweet dreams, my love. 🌟 I'll be dreaming of you too. 😴❤️",
    "Sleep tight, beautiful. 🌌 Tomorrow is another day to love you more. 😘",
  ];

  List<String> _randomQuotes = [
    "Love is not about how many days, but how much you mean to me. 💖",
    "You are my everything. 🌹",
    "In your eyes, I found my paradise. 😍",
  ];

  List<String> _favorites = [];
  List<String> _customMessages = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeNotifications();
    _loadData();
    _startMessageOfTheDayTimer();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _customMessageController.dispose();
    _messageOfTheDayTimer?.cancel();
    super.dispose();
  }

  void _initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _notifications.initialize(settings);
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites') ?? [];
      _customMessages = prefs.getStringList('customMessages') ?? [];
    });
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites);
    await prefs.setStringList('customMessages', _customMessages);
  }

  void _startMessageOfTheDayTimer() {
    _messageOfTheDayTimer = Timer.periodic(const Duration(hours: 24), (timer) {
      setState(() {
        _messageOfTheDay = _randomQuotes[Random().nextInt(_randomQuotes.length)];
      });
    });
  }

  void _sendDailyNotification() async {
    const androidDetails = AndroidNotificationDetails('daily_channel', 'Daily Love Notes', channelDescription: 'Daily romantic reminders');
    const notificationDetails = NotificationDetails(android: androidDetails);
    await _notifications.show(0, 'Daily Love Note', _messageOfTheDay, notificationDetails);
  }

  void _addCustomMessage() {
    if (_customMessageController.text.isNotEmpty) {
      setState(() {
        _customMessages.add(_customMessageController.text);
        _customMessageController.clear();
      });
      _saveData();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Custom message added! ❤️')));
    }
  }

  void _toggleFavorite(String message) {
    setState(() {
      if (_favorites.contains(message)) {
        _favorites.remove(message);
      } else {
        _favorites.add(message);
      }
    });
    _saveData();
  }

  void _copyToClipboard(String message) {
    Clipboard.setData(ClipboardData(text: message));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message copied to clipboard! 📋')));
  }

  void _shareMessage(String message) {
    Share.share(message);
  }

  void _reloadQuotes() {
    setState(() {
      _randomQuotes.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Love Messages'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Good Morning'),
            Tab(text: 'Good Night'),
            Tab(text: 'Random Quotes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMessageList(_goodMorningMessages + _customMessages),
          _buildMessageList(_goodNightMessages + _customMessages),
          _buildQuoteList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCustomDialog(),
        child: const Icon(Icons.add),
        tooltip: 'Add personalized message',
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_messageOfTheDay, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _sendDailyNotification,
                  icon: const Icon(Icons.notifications),
                  label: const Text('Daily Note'),
                ),
                ElevatedButton.icon(
                  onPressed: _reloadQuotes,
                  icon: const Icon(Icons.refresh),
                  label: const Text('New Quotes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(List<String> messages) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isFavorite = _favorites.contains(message);
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                      onPressed: () => _toggleFavorite(message),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () => _copyToClipboard(message),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () => _shareMessage(message),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuoteList() {
    return _buildMessageList(_randomQuotes);
  }

  void _showAddCustomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Personalized Message'),
        content: TextField(
          controller: _customMessageController,
          decoration: const InputDecoration(hintText: 'Type your romantic message... 💕'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _addCustomMessage();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}