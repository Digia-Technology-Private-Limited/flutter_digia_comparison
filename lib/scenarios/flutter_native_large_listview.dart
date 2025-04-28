import 'package:flutter/material.dart';

class FlutterLargeListView extends StatelessWidget {
  const FlutterLargeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(1000, (index) => 'Item #$index');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Large ListView - Flutter'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.grey.shade900,
            leading: Image.asset(
              'assets/static_image.png',
              width: 40,
              height: 40,
            ),
            title: Text(
              items[index],
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped ${items[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}