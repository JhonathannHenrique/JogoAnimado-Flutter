import 'package:flutter/material.dart';

// REQUISITO 5: CustomPainter
// Desenha faixas de sinalização de pista, criando profundidade visual simples.
class TrackPainter extends CustomPainter {
  final Color stripeColor;
  final double animationValue;

  TrackPainter({
    required this.stripeColor,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = stripeColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    
    final path = Path();
    
    // Desenha uma pista em perspectiva na parte inferior
    path.moveTo(size.width * 0.45, size.height * 0.5);
    path.lineTo(size.width * 0.55, size.height * 0.5);
    path.lineTo(size.width * 0.9, size.height);
    path.lineTo(size.width * 0.1, size.height);
    path.close();
    
    canvas.drawPath(path, paint);

    // Linha central da pista tracejada
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    
    final int dashCount = 5;
    final double dashHeight = (size.height / 2) / (dashCount * 2);
    
    canvas.save();
    canvas.clipRect(Rect.fromLTRB(0, size.height * 0.5, size.width, size.height));

    for (int i = -1; i <= dashCount; i++) {
      final double offset = animationValue * (2 * dashHeight);
      final double startY = size.height * 0.5 + (i * 2 * dashHeight) + offset;
      final double endY = startY + dashHeight;
      
      canvas.drawLine(
        Offset(size.width * 0.5, startY),
        Offset(size.width * 0.5, endY),
        linePaint,
      );
    }
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant TrackPainter oldDelegate) {
    return oldDelegate.stripeColor != stripeColor ||
           oldDelegate.animationValue != animationValue;
  }
}
