import 'dart:math';

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
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;



    if (points.isNotEmpty) {
      Path path = Path();
      path.moveTo(points[0].dx, points[0].dy);

     // for (int i = 1; i < points.length; i++) {
      //  path.lineTo(points[i].dx, points[i].dy);

    //  }
      for (var i=1 ; i<points.length-2; i++){
        var xc =(points[i].dx+points[i+i].dx)/2;
        var yc =(points[i].dy+points[i+i].dy)/2;
        path.quadraticBezierTo(points[i].dx, points[i].dy, xc, yc);
      }

      
      path.quadraticBezierTo(
        points[points.length-2].dx,
        points[points.length-2].dy,
        points[points.length-1].dx,
        points[points.length-1].dy,
          );
      /*List<Color> pointColors = List.generate(
        double.infinity.toInt(),
            (index) => Color.fromARGB(
          255,
          Random().nextInt(256),
          Random().nextInt(256),
          Random().nextInt(256),
        ),
      );*/
      //List<Color> pointColors = [Colors.red, Colors.orange, Colors.yellow, Colors.green];
      for (int i = 0; i < points.length; i++) {
        Paint pointPaint = Paint()
          ..color = Color_2//pointColors[i]
          ..strokeWidth = 8.0
          ..style = PaintingStyle.fill;
        canvas.drawCircle(points[i], 5.0, pointPaint);
      }


      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
