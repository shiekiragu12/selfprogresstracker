import 'package:flutter/material.dart';
import '../components/_card.dart'; 

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Colored Card Example')),
      body: ListView(
        children: [
          CustomCard(
            title: 'Green Card',
            subtitle: 'This card has a green background.',
            icon: Icons.check_circle,
            cardColor: Colors.green,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Green card tapped!')),
              );
            },
          ),
          CustomCard(
            title: 'Purple Card',
            subtitle: 'This card has a purple background.',
            icon: Icons.star,
            cardColor: Colors.purple,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purple card tapped!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
