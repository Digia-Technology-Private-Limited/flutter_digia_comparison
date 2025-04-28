import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FlutterHeavyLottieScreen extends StatelessWidget {
  const FlutterHeavyLottieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> lottieUrls = List.generate(
      40,
          (index) => 'https://assets9.lottiefiles.com/packages/lf20_totrpclr.json', // Same animation for demo
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Heavy Lottie Screen'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: lottieUrls.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Lottie.network(
              lottieUrls[index],
              repeat: true,
              animate: true,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
