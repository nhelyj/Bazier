import 'package:bazier/media.dart';
import 'package:flutter/material.dart';

class schedule extends CustomPainter {
  final List<Offset> points;
  final double t;

  schedule({required this.points, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color_2
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    if (points.isEmpty) return;

    // Вычисление минимальных и максимальных координат
    double minX = points.map((p) => p.dx).reduce((a, b) => a < b ? a : b);
    double maxX = points.map((p) => p.dx).reduce((a, b) => a > b ? a : b);
    double minY = points.map((p) => p.dy).reduce((a, b) => a < b ? a : b);
    double maxY = points.map((p) => p.dy).reduce((a, b) => a > b ? a : b);

    // Вычисление масштабирования
    double scaleX = size.width / (maxX - minX);
    double scaleY = size.height / (maxY - minY);
    double scale = scaleX < scaleY ? scaleX : scaleY;

    // Перенос начала координат в центр и масштабирование
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(scale, -scale);

    // Смещение графика, чтобы центрировать его
    double offsetX = -(minX + maxX) / 2;
    double offsetY = -(minY + maxY) / 2;
    canvas.translate(offsetX, offsetY);

    Path path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    // Проверка на количество точек
    //if (points.length == 2) {
    //  path.lineTo(points[1].dx, points[1].dy);
   // } else {
      for (var i = 1; i < points.length - 2; i++) {
        var xc = (points[i].dx + points[i + 1].dx) / 2;
        var yc = (points[i].dy + points[i + 1].dy) / 2;
        path.quadraticBezierTo(points[i].dx, points[i].dy, xc, yc);

      }
      path.quadraticBezierTo(
        points[points.length - 2].dx,
        points[points.length - 2].dy,
        points[points.length - 1].dx,
        points[points.length - 1].dy,
      );
    //}

    for (int i = 0; i < points.length; i++) {
      Paint pointPaint = Paint()
        ..color = Color_2
        ..strokeWidth = 10
        ..style = PaintingStyle.fill;
      canvas.drawCircle(points[i], 5.0 / scale, pointPaint);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


