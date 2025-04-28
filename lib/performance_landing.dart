import 'package:flutter/material.dart';
import 'package:flutter_digia_comparison/scenario_selector/ScenarioSelectorScreen.dart';
import 'FloatingStatsOverlay.dart';
import '../main.dart'; // ✅ Import main.dart to access `startupStopwatch`

class PerformanceLanding extends StatefulWidget {
  const PerformanceLanding({super.key});

  @override
  State<PerformanceLanding> createState() => _PerformanceLandingState();
}

class _PerformanceLandingState extends State<PerformanceLanding> {
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FloatingStatsOverlay.show(context);

      Future.delayed(Duration(milliseconds: 50), () {
        if (startupStopwatch.isRunning) {
          startupStopwatch.stop();
          debugPrint('🚀 App Cold Start Time: ${startupStopwatch.elapsedMilliseconds} ms');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Benchmarking'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              item.description,
              style: const TextStyle(color: Colors.white70),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ScenarioSelectorScreen(
                  title: item.title,
                  description: item.description,
                  digiaPageName: item.routeName.replaceAll('/', ''),
                ),
              ),
            ),
          );
        },
      ),
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
