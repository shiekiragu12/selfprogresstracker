import 'package:flutter/material.dart';
import '../_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class CardsMetrics extends StatefulWidget {
  const CardsMetrics({super.key});

  @override
  State<CardsMetrics> createState() => _CardsMetricsState();
}

class _CardsMetricsState extends State<CardsMetrics> {
  String _username = 'User';
  String _greeting = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _setGreeting();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('username') ?? 'User';
    setState(() {
      _username = name;
    });
  }

  void _setGreeting() {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
    setState(() {
      _greeting = greeting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👋 Greeting
          Text(
            '$_greeting, $_username 👋',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.amber[800],
            ),
          ),
          const SizedBox(height: 20),

          // 📊 Metrics Cards in Grid
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2,
              children: const [
                CustomCard(
                  title: 'Productive Days',
                  subtitle: '20',
                  icon: Icons.run_circle_outlined,
                  cardColor: Colors.green,
                ),
                CustomCard(
                  title: 'Dormant Days',
                  subtitle: '10',
                  icon: Icons.dark_mode_outlined,
                  cardColor: Colors.grey,
                ),
                CustomCard(
                  title: 'Achieved Goals',
                  subtitle: '50',
                  icon: Icons.verified,
                  cardColor: Colors.purple,
                ),
                CustomCard(
                  title: 'Total Goals Set',
                  subtitle: '30',
                  icon: Icons.checklist_rtl_sharp,
                  cardColor: Colors.orange,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text("Today's Tasks", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
              },
              child: const Text("See All"),
            ),
          ),
          // You can use a ListView.builder or Card here
          Card(
            child: ListTile(
              title: Text('Design new goal cards'),
              subtitle: Text('Due today'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Push latest update'),
              subtitle: Text('Due today'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Review weekly progress'),
              subtitle: Text('Due today'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Progress Charts",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 100,
            child: Center(child: Text("📊 Bar chart goes here")),
          ),

          const SizedBox(height: 20),

          // 🥧 TODO: Pie Chart Placeholder
          Text("Goal Overview", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(
            height: 100,
            child: Center(child: Text("🥧 Pie chart goes here")),
          ),

          const SizedBox(height: 20),

          // 🔍 TODO: Filtering Placeholder
          Text(
            "Filter Options",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 50,
            child: Center(
              child: Text("🔘 Filter buttons or dropdowns go here"),
            ),
          ),
        ],
      ),
    );
  }
}
