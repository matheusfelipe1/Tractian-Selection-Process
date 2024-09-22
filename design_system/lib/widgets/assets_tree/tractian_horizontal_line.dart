part of 'tractian_assets_tree.dart';

class _TractianHorizontalLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = TractianColors.gray100;

    canvas.drawLine(Offset(-8, size.height), Offset(size.width * 0.08, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
