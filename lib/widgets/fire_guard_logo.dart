import 'package:fire_guard/theme/colors.dart';
import 'package:flutter/material.dart';

class FireGuardLogo extends StatelessWidget {
  const FireGuardLogo({super.key, this.size = 180});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(painter: _FireGuardLogoPainter()),
        );
      },
    );
  }
}

class _FireGuardLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final shieldPaint = Paint()
      ..color = darkBlue
      ..style = PaintingStyle.fill;

    final flamePaint = Paint()
      ..color = red
      ..style = PaintingStyle.fill;

    final shieldPath = Path()
      ..moveTo(size.width * 0.50, 0)
      ..lineTo(size.width * 0.18, size.height * 0.16)
      ..cubicTo(
        size.width * 0.04,
        size.height * 0.36,
        0,
        size.height * 0.58,
        0,
        size.height * 0.65,
      )
      ..cubicTo(
        0,
        size.height * 0.86,
        size.width * 0.18,
        size.height,
        size.width * 0.38,
        size.height,
      )
      ..lineTo(size.width * 0.62, size.height)
      ..cubicTo(
        size.width * 0.82,
        size.height,
        size.width,
        size.height * 0.86,
        size.width,
        size.height * 0.65,
      )
      ..cubicTo(
        size.width,
        size.height * 0.58,
        size.width * 0.96,
        size.height * 0.36,
        size.width * 0.82,
        size.height * 0.16,
      )
      ..close();

    final flamePath = Path()
      ..moveTo(size.width * 0.50, size.height * 0.22)
      ..cubicTo(
        size.width * 0.74,
        size.height * 0.12,
        size.width * 0.88,
        size.height * 0.28,
        size.width * 0.76,
        size.height * 0.43,
      )
      ..cubicTo(
        size.width * 0.92,
        size.height * 0.50,
        size.width * 0.88,
        size.height * 0.72,
        size.width * 0.62,
        size.height * 0.82,
      )
      ..cubicTo(
        size.width * 0.78,
        size.height * 0.90,
        size.width * 0.72,
        size.height * 0.98,
        size.width * 0.52,
        size.height * 0.94,
      )
      ..cubicTo(
        size.width * 0.65,
        size.height * 0.92,
        size.width * 0.60,
        size.height * 0.84,
        size.width * 0.54,
        size.height * 0.80,
      )
      ..cubicTo(
        size.width * 0.42,
        size.height * 0.82,
        size.width * 0.36,
        size.height * 0.64,
        size.width * 0.42,
        size.height * 0.56,
      )
      ..cubicTo(
        size.width * 0.30,
        size.height * 0.52,
        size.width * 0.20,
        size.height * 0.32,
        size.width * 0.34,
        size.height * 0.28,
      )
      ..cubicTo(
        size.width * 0.39,
        size.height * 0.24,
        size.width * 0.44,
        size.height * 0.18,
        size.width * 0.50,
        size.height * 0.22,
      )
      ..close();

    final innerFlamePaint = Paint()
      ..color = const Color(0xFFD91F1F)
      ..style = PaintingStyle.fill;

    final innerFlamePath = Path()
      ..moveTo(size.width * 0.50, size.height * 0.32)
      ..cubicTo(
        size.width * 0.64,
        size.height * 0.30,
        size.width * 0.76,
        size.height * 0.39,
        size.width * 0.68,
        size.height * 0.52,
      )
      ..cubicTo(
        size.width * 0.76,
        size.height * 0.58,
        size.width * 0.72,
        size.height * 0.74,
        size.width * 0.56,
        size.height * 0.82,
      )
      ..cubicTo(
        size.width * 0.62,
        size.height * 0.82,
        size.width * 0.58,
        size.height * 0.71,
        size.width * 0.52,
        size.height * 0.68,
      )
      ..cubicTo(
        size.width * 0.42,
        size.height * 0.66,
        size.width * 0.38,
        size.height * 0.54,
        size.width * 0.42,
        size.height * 0.46,
      )
      ..cubicTo(
        size.width * 0.32,
        size.height * 0.44,
        size.width * 0.28,
        size.height * 0.38,
        size.width * 0.39,
        size.height * 0.34,
      )
      ..cubicTo(
        size.width * 0.43,
        size.height * 0.31,
        size.width * 0.46,
        size.height * 0.31,
        size.width * 0.50,
        size.height * 0.32,
      )
      ..close();

    canvas.drawShadow(shieldPath, Colors.black.withValues(alpha: 0.24), 10, false);
    canvas.drawPath(shieldPath, shieldPaint);
    canvas.drawPath(flamePath, flamePaint);
    canvas.drawPath(innerFlamePath, innerFlamePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
