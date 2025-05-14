import 'package:flutter/cupertino.dart';

class VArrowWidget extends CustomPainter {
  final Color borderColor;
  final Color fillColor;

  VArrowWidget({
    required this.borderColor,
    required this.fillColor
  });

  @override
  void paint(Canvas canvas, Size size) {

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final outerPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, 0) //좌상단 시작
      ..lineTo(size.width / 2, size.height * 3 / 4) //아래중앙
      ..lineTo(size.width, 0) //우상단
      ..moveTo(size.width, 0) //우상단 시작
      ..lineTo(size.width, size.height * 1 / 4)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height * 1 / 4)
      ..lineTo(0, 0);

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, outerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
