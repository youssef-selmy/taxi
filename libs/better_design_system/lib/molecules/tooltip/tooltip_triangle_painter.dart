part of 'tooltip.dart';

class _TooltipTrianglePainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final Alignment alignment;

  _TooltipTrianglePainter({
    required this.fillColor,
    required this.borderColor,
    required this.alignment,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    if (alignment == Alignment.topCenter) {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width / 2, 0);
    } else if (alignment == Alignment.bottomCenter) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    } else if (alignment == Alignment.centerRight) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height / 2);
    } else if (alignment == Alignment.centerLeft) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height / 2);
    }

    path.close();
    canvas.drawPath(path, paint);

    if (alignment == Alignment.topCenter ||
        alignment == Alignment.bottomCenter) {
      canvas.drawLine(
        Offset(0, alignment == Alignment.topCenter ? size.height : 0),
        Offset(
          size.width / 2,
          alignment == Alignment.topCenter ? 0 : size.height,
        ),
        borderPaint,
      );
      canvas.drawLine(
        Offset(size.width, alignment == Alignment.topCenter ? size.height : 0),
        Offset(
          size.width / 2,
          alignment == Alignment.topCenter ? 0 : size.height,
        ),
        borderPaint,
      );
    } else if (alignment == Alignment.centerRight ||
        alignment == Alignment.centerLeft) {
      canvas.drawLine(
        Offset(alignment == Alignment.centerRight ? 0 : size.width, 0),
        Offset(
          alignment == Alignment.centerRight ? size.width : 0,
          size.height / 2,
        ),
        borderPaint,
      );
      canvas.drawLine(
        Offset(
          alignment == Alignment.centerRight ? 0 : size.width,
          size.height,
        ),
        Offset(
          alignment == Alignment.centerRight ? size.width : 0,
          size.height / 2,
        ),
        borderPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
