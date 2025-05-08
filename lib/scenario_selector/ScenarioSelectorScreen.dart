import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ScenarioSelectorScreen extends StatefulWidget {
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
  State<ScenarioSelectorScreen> createState() => _ScenarioSelectorScreenState();
}

class _ScenarioSelectorScreenState extends State<ScenarioSelectorScreen> {
  // FPS Tracking variables
  int _frameCount = 0;
  double _totalFrameTimeMs = 0;
  int _slowFrameCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.description,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            _buildButton(
              context,
              label: '🔷 Run in Flutter (Client-Driven)',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => widget.flutterPage),
              ),
            ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              label: '🟦 Run in Digia (Server-Driven)',
              onTap: () => Navigator.push(
                context,
                DUIFactory().createPageRoute(widget.digiaPageName, {}),
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
      onPressed: () {
        _resetFPSStats();  // RESET counters
        _startFPSCapture();  // START FPS capture
        onTap(); // Navigate
      },
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  void _resetFPSStats() {
    _frameCount = 0;
    _totalFrameTimeMs = 0;
    _slowFrameCount = 0;
  }

  void _startFPSCapture() {
    SchedulerBinding.instance.addTimingsCallback(_handleFrameTimings);
  }

  void _handleFrameTimings(List<FrameTiming> timings) {
    for (final timing in timings) {
      final totalFrameTimeMs = timing.totalSpan.inMicroseconds / 1000;

      _frameCount++;
      _totalFrameTimeMs += totalFrameTimeMs;

      if (totalFrameTimeMs > 16.67) {
        _slowFrameCount++;
      } 
    }

    if (_frameCount >= 120) { // after 120 frames (~2 sec at 60fps)
      final avgFrameTime = _totalFrameTimeMs / _frameCount;
      final avgFPS = 1000 / avgFrameTime;

      print('📈 FPS Report: Avg FPS: ${avgFPS.toStringAsFixed(2)}, '
          'Total Frames: $_frameCount, '
          'Slow Frames: $_slowFrameCount');
      _resetFPSStats();
    }
  }
}
