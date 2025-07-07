import 'package:flutter/material.dart';
import '../_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import './progress_bar_chart.dart';
import './goal_pie_chart.dart';

class CardsMetrics extends StatefulWidget {
  const CardsMetrics({super.key});

  @override
  State<CardsMetrics> createState() => _CardsMetricsState();
}

class _CardsMetricsState extends State<CardsMetrics> {
  String _username = 'User';
  String _greeting = '';
  String selectedFilter = 'All';

  final List<String> filterOptions = [
    'All',
    'Completed',
    'Pending',
    'In Progress',
  ];

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

          // 🧮 Filter Options with Dropdown
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedFilter = value;
                        });
                      }
                    },
                    underline: Container(),
                    style: const TextStyle(color: Colors.black),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    items: filterOptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 📅 Tasks
          Text("Today's Tasks", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: () {}, child: const Text("See All")),
          ),
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

          // 📊 Progress Charts
          Text(
            "Progress Charts",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 200,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ProgressBarChart(),
            ),
          ),

          const SizedBox(height: 20),

          // 🥧 Goal Overview Section
          Text("Goal Overview", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(
            height: 180,
            child: Padding(padding: EdgeInsets.all(8.0), child: GoalPieChart()),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
