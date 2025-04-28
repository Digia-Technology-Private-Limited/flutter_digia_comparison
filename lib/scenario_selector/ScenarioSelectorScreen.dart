import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';

class ScenarioSelectorScreen extends StatelessWidget {
  final String title;
  final String description;
  final Widget flutterPage;
  final String digiaPageName;

  const ScenarioSelectorScreen({
    super.key,
    required this.title,
    required this.description,
    required this.flutterPage,
    required this.digiaPageName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            _buildButton(
              context,
              label: '🔷 Run in Flutter (Client-Driven)',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => flutterPage),
              ),
            ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              label: '🟦 Run in Digia (Server-Driven)',
              onTap: () => Navigator.push(
                context,
                DUIFactory().createPageRoute(digiaPageName, {}),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String label, required VoidCallback onTap}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white10,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
