import 'package:flutter/material.dart';
import 'package:flutter_digia_comparison/scenario_selector/ScenarioSelectorScreen.dart';
import 'package:flutter_digia_comparison/scenarios/DynamicApiListView.dart';

// 👉 Import your Flutter listview pages here
import 'package:flutter_digia_comparison/scenarios/flutter_native_large_listview.dart';

class ListViewScenariosScreen extends StatelessWidget {
  const ListViewScenariosScreen({super.key});

  final List<_ListViewScenario> _scenarios = const [
    _ListViewScenario(
      title: '📋 Static ListView',
      description: 'Simple large static list performance.',
      flutterPage: FlutterLargeListView(),
      digiaPageName: 'digia_static_listview',
    ),
    _ListViewScenario(
      title: '🌐 Dynamic API ListView',
      description: 'List built from server data.',
      flutterPage: DynamicApiListView(),
      digiaPageName: 'digia_dynamic_api_listview',
    ),
    _ListViewScenario(
      title: '🔄 Paginated ListView',
      description: 'Lazy loading more items on scroll.',
      flutterPage: DynamicApiListView(),
      digiaPageName: 'digia_paginated_listview',
    ),
    _ListViewScenario(
      title: '🎞️ Animated ListView',
      description: 'Animated list item appearance.',
      flutterPage: DynamicApiListView(),
      digiaPageName: 'digia_animated_listview',
    ),
    _ListViewScenario(
      title: '🧹 Swipeable ListView',
      description: 'Swipe-to-dismiss list items.',
      flutterPage: DynamicApiListView(),
      digiaPageName: 'digia_swipeable_listview',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Scenarios'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _scenarios.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final scenario = _scenarios[index];
          return ListTile(
            tileColor: Colors.grey.shade900,
            title: Text(
              scenario.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              scenario.description,
              style: const TextStyle(color: Colors.white70),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ScenarioSelectorScreen(
                    title: scenario.title,
                    description: scenario.description,
                    flutterPage: scenario.flutterPage,
                    digiaPageName: scenario.digiaPageName,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ListViewScenario {
  final String title;
  final String description;
  final Widget flutterPage;
  final String digiaPageName;

  const _ListViewScenario({
    required this.title,
    required this.description,
    required this.flutterPage,
    required this.digiaPageName,
  });
}
