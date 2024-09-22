part of '../widgets/tractian_assets_tree_widget.dart';

class _TractianVerticalLinePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = TractianColors.gray100;

    canvas.drawLine(const Offset(8, 0), Offset(8, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
