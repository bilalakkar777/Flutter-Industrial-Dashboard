import 'package:flutter/material.dart';

class SimpleWorldMap extends StatefulWidget {
  final Map<String, Color> countryColors;
  final Function(String countryId, String countryName)? onCountryTap;
  final Color defaultColor;

  const SimpleWorldMap({
    Key? key,
    this.countryColors = const {},
    this.onCountryTap,
    this.defaultColor = const Color.fromARGB(255, 106, 100, 100),
  }) : super(key: key);

  @override
  State<SimpleWorldMap> createState() => _SimpleWorldMapState();
}

class _SimpleWorldMapState extends State<SimpleWorldMap> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.defaultColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Stack(
        children: [
          // Background with world map pattern
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.defaultColor,
                    widget.defaultColor.withOpacity(0.8),
                    widget.defaultColor,
                  ],
                ),
              ),
              child: CustomPaint(
                painter: WorldMapPainter(
                  countryColors: widget.countryColors,
                  selectedCountry: selectedCountry,
                  defaultColor: widget.defaultColor,
                ),
              ),
            ),
          ),
          // Interactive overlay
          Positioned.fill(
            child: GestureDetector(
              onTapDown: (details) {
                final country = _getCountryFromPosition(details.localPosition);
                if (country != null) {
                  setState(() {
                    selectedCountry = country;
                  });
                  widget.onCountryTap?.call(country, _getCountryName(country));
                }
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Map title
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Interactive World Map',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Selected country info
          if (selectedCountry != null)
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Selected: ${_getCountryName(selectedCountry!)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String? _getCountryFromPosition(Offset position) {
    // Simple country detection based on position
    if (position.dx > 100 && position.dx < 200 && position.dy > 80 && position.dy < 120) {
      return 'DE'; // Germany
    } else if (position.dx > 300 && position.dx < 400 && position.dy > 60 && position.dy < 100) {
      return 'US'; // USA
    } else if (position.dx > 200 && position.dx < 300 && position.dy > 200 && position.dy < 250) {
      return 'BR'; // Brazil
    } else if (position.dx > 150 && position.dx < 250 && position.dy > 120 && position.dy < 160) {
      return 'IT'; // Italy
    } else if (position.dx > 250 && position.dx < 350 && position.dy > 100 && position.dy < 140) {
      return 'MA'; // Morocco
    } else if (position.dx > 350 && position.dx < 450 && position.dy > 80 && position.dy < 120) {
      return 'TR'; // Turkey
    }
    return null;
  }

  String _getCountryName(String countryId) {
    switch (countryId) {
      case 'DE': return 'Germany';
      case 'US': return 'United States';
      case 'BR': return 'Brazil';
      case 'IT': return 'Italy';
      case 'MA': return 'Morocco';
      case 'TR': return 'Turkey';
      default: return 'Unknown';
    }
  }
}

class WorldMapPainter extends CustomPainter {
  final Map<String, Color> countryColors;
  final String? selectedCountry;
  final Color defaultColor;

  WorldMapPainter({
    required this.countryColors,
    this.selectedCountry,
    required this.defaultColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;

    // Draw simplified country shapes with better visibility
    _drawCountry(canvas, size, 'DE', const Offset(150, 100), paint, strokePaint);
    _drawCountry(canvas, size, 'US', const Offset(350, 80), paint, strokePaint);
    _drawCountry(canvas, size, 'BR', const Offset(250, 225), paint, strokePaint);
    _drawCountry(canvas, size, 'IT', const Offset(200, 140), paint, strokePaint);
    _drawCountry(canvas, size, 'MA', const Offset(300, 120), paint, strokePaint);
    _drawCountry(canvas, size, 'TR', const Offset(400, 100), paint, strokePaint);

    // Draw connection lines
    _drawConnectionLines(canvas, size, strokePaint);
  }

  void _drawCountry(Canvas canvas, Size size, String countryId, Offset center, Paint paint, Paint strokePaint) {
    final color = countryColors[countryId] ?? defaultColor;
    final isSelected = selectedCountry == countryId;
    
    paint.color = isSelected ? color.withOpacity(0.9) : color.withOpacity(0.7);
    
    // Draw country as a rounded rectangle (more visible)
    final rect = Rect.fromCenter(center: center, width: 80, height: 50);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12)), paint);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12)), strokePaint);
    
    // Draw country label with better visibility
    final textPainter = TextPainter(
      text: TextSpan(
        text: countryId,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              color: Colors.black,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }

  void _drawConnectionLines(Canvas canvas, Size size, Paint strokePaint) {
    strokePaint.color = Colors.blue.withOpacity(0.6);
    strokePaint.strokeWidth = 2;
    
    // Draw some connection lines between countries
    canvas.drawLine(
      const Offset(150, 100), // Germany
      const Offset(350, 80),  // USA
      strokePaint,
    );
    
    canvas.drawLine(
      const Offset(200, 140), // Italy
      const Offset(300, 120), // Morocco
      strokePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is WorldMapPainter &&
        (oldDelegate.countryColors != countryColors ||
         oldDelegate.selectedCountry != selectedCountry);
  }
}