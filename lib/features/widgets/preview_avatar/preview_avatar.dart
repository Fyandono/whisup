import 'package:flutter/material.dart';

class PixelAvatarPreview extends StatelessWidget {
  final Map<String, Color> pixels;
  final int gridSize;
  final double size;
  final double borderWidth;
  final Color borderColor;

  const PixelAvatarPreview({
    super.key,
    required this.pixels,
    this.gridSize = 7,
    this.size = 80,
    this.borderWidth = 1.5,
    this.borderColor = Colors.black12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      width: size + borderWidth * 2,
      height: size + borderWidth * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: CustomPaint(
        size: Size.square(size),
        painter: _PixelAvatarPainter(pixels: pixels, gridSize: gridSize),
      ),
    );
  }
}

class _PixelAvatarPainter extends CustomPainter {
  final Map<String, Color> pixels;
  final int gridSize;

  _PixelAvatarPainter({required this.pixels, required this.gridSize});

  @override
  void paint(Canvas canvas, Size size) {
    final double pixelSize = size.width / gridSize;
    final paint = Paint();

    for (int x = 0; x < gridSize; x++) {
      for (int y = 0; y < gridSize; y++) {
        final key = '${x}_$y';
        if (pixels.containsKey(key)) {
          paint.color = pixels[key]!;
          canvas.drawRect(
            Rect.fromLTWH(x * pixelSize, y * pixelSize, pixelSize, pixelSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PixelAvatarPainter oldDelegate) =>
      oldDelegate.pixels != pixels;
}
