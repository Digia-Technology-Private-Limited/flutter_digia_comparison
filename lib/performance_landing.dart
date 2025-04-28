import 'package:flutter/material.dart';
import 'package:flutter_digia_comparison/scenario_selector/ScenarioSelectorScreen.dart';

class PerformanceLanding extends StatelessWidget {
  const PerformanceLanding({super.key});

  final List<_PerformanceItem> _items = const [
    _PerformanceItem(
      title: '🧩 Static ListView',
      routeName: '/staticList',
      description: 'Compare list rendering performance between CDUI and SDUI.',
    ),
    _PerformanceItem(
      title: '🎞️ Animation-Heavy Screen',
      routeName: '/animationScreen',
      description: 'Assess frame rate and jank in animation-heavy UI.',
    ),
    _PerformanceItem(
      title: '🧾 Form + Network API',
      routeName: '/formApi',
      description: 'Measure input latency and async handling performance.',
    ),
    _PerformanceItem(
      title: '🧭 Navigation & Deep Linking',
      routeName: '/navigation',
      description: 'Understand route rendering and deep linking behavior.',
    ),
    _PerformanceItem(
      title: '📊 CPU & Memory Benchmark',
      routeName: '/cpuMemory',
      description: 'Dive into profiling insights across scenarios.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Benchmarking'),
        backgroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            tileColor: Colors.grey.shade900,
            title: Text(
              item.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(item.description, style: const TextStyle(color: Colors.white70)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ScenarioSelectorScreen(
                  title: '🧩 Static ListView',
                  description: 'Render 1000 items in a ListView to benchmark scroll & FPS.',
                  digiaPageName: 'static_list_sdui', // Replace with actual Digia config page name
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}

class _PerformanceItem {
  final String title;
  final String routeName;
  final String description;

  const _PerformanceItem({
    required this.title,
    required this.routeName,
    required this.description,
  });
}