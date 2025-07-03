import 'package:flutter/material.dart';
import '_card.dart'; // make sure the path is correct

class CardsMetrics extends StatelessWidget {
  const CardsMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
