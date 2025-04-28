import 'package:flutter/material.dart';
import 'package:statsfl/statsfl.dart';

class FloatingStatsOverlay {
  static OverlayEntry? _overlayEntry;
  static Offset _position = const Offset(20, 100); // Top left starting position

  static void show(BuildContext context) {
    if (_overlayEntry != null) return; // already showing
    print('FloatingStatsOverlay inserted at $_position');
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: _position.dx,
        top: _position.dy,
        child: GestureDetector(
          onPanUpdate: (details) {
            _position += details.delta;
            _overlayEntry?.markNeedsBuild();
          },
          child: Material(
            color: Colors.transparent,
            child: StatsFl(
              width: 250, // ✅ Make it wide enough
              height: 120, // ✅ Tall enough
              isEnabled: true, // ✅ Must be true
              showText: true,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true)?.insert(_overlayEntry!);
  }

  static void hide() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  static bool get isShowing => _overlayEntry != null;

  static void toggle(BuildContext context) {
    if (isShowing) {
      hide();
    } else {
      show(context);
    }
  }
}
