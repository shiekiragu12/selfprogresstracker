import 'package:flutter/material.dart';
import '../components/_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber[600],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
           
            title: null,
          ),
        ),
      ),

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
