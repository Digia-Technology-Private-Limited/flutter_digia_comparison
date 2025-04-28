import 'package:flutter/material.dart';
import 'package:flutter_digia_comparison/scenario_selector/ScenarioSelectorScreen.dart';
import 'package:flutter_digia_comparison/scenarios/ListViewScenariosScreen.dart';
import 'FloatingStatsOverlay.dart';
import '../main.dart';

class PerformanceLanding extends StatefulWidget {
  const PerformanceLanding({super.key});

  @override
  State<PerformanceLanding> createState() => _PerformanceLandingState();
}

class _PerformanceLandingState extends State<PerformanceLanding> {
  final List<_PerformanceSection> _sections = [
    _PerformanceSection(
      title: '📝 ListView Benchmarks',
      items: [
        _PerformanceItem(
          title: '📝 Go to ListView Scenarios',
          routeName: '/listViewScenarios',
          description: 'Explore different ListView performance tests.',
          isNavigationToListViewScenarios: true,
        ),
      ],
    ),
    _PerformanceSection(
      title: '🚀 Other Performance Scenarios',
      items: [
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
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FloatingStatsOverlay.show(context);

      Future.delayed(const Duration(milliseconds: 50), () {
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _sections.length,
        itemBuilder: (context, sectionIndex) {
          final section = _sections[sectionIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...section.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ListTile(
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
                  onTap: () {
                    if (item.isNavigationToListViewScenarios) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ListViewScenariosScreen(),
                        ),
                      );
                    } else {
                      // You can later extend this for other specific navigations
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Coming soon!')),
                      );
                    }
                  },
                ),
              )),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

class _PerformanceSection {
  final String title;
  final List<_PerformanceItem> items;

  const _PerformanceSection({required this.title, required this.items});
}

class _PerformanceItem {
  final String title;
  final String routeName;
  final String description;
  final bool isNavigationToListViewScenarios;

  const _PerformanceItem({
    required this.title,
    required this.routeName,
    required this.description,
    this.isNavigationToListViewScenarios = false,
  });
}
