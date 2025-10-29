import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pcfsim_ui/constants/controllers.dart';
import 'package:pcfsim_ui/helpers/reponsiveness.dart';
import 'package:pcfsim_ui/pages/home/widgets/home_table.dart';
import 'package:pcfsim_ui/widgets/custom_text.dart';
import 'package:get/get.dart';


import 'package:pcfsim_ui/pages/overview/widgets/overview_cards_large.dart';
import 'package:pcfsim_ui/pages/overview/widgets/overview_cards_medium.dart';
import 'package:pcfsim_ui/pages/overview/widgets/overview_cards_small.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pcfsim_ui/widgets/osm_map.dart';

class AnimatedAirplane extends StatefulWidget {
  final BuildContext context;

  AnimatedAirplane({required this.context});

  @override
  _AnimatedAirplaneState createState() => _AnimatedAirplaneState();
}

class _AnimatedAirplaneState extends State<AnimatedAirplane>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> positions;
  late List<Offset> velocities;
  final int numAirplanes = 100;
  final random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
    positions = generateRandomPositions();
    velocities = generateRandomVelocities();
    _controller.addListener(() {
      setState(() {
        updatePositions();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updatePositions() {
    for (int i = 0; i < numAirplanes; i++) {
      double dx = positions[i].dx + velocities[i].dx;
      double dy = positions[i].dy + velocities[i].dy;

      // Simulate boundaries for the screen
      if (dx < 0) {
        dx = MediaQuery.of(context).size.width;
      } else if (dx > MediaQuery.of(context).size.width) {
        dx = 0;
      }

      if (dy < 0) {
        dy = MediaQuery.of(context).size.height;
      } else if (dy > MediaQuery.of(context).size.height) {
        dy = 0;
      }

      positions[i] = Offset(dx, dy);
    }
  }

  List<Offset> generateRandomPositions() {
    final List<Offset> newPositions = [];
    final Size screenSize = MediaQuery.of(widget.context).size;
    final double intervalWidth =
        screenSize.width / 10; // Divide width into 10 intervals
    final double intervalHeight =
        screenSize.height / 10; // Divide height into 10 intervals

    for (int i = 0; i < numAirplanes; i++) {
      final double x = random.nextInt(10).toDouble() * intervalWidth +
          random.nextDouble() * intervalWidth;
      final double y = random.nextInt(10).toDouble() * intervalHeight +
          random.nextDouble() * intervalHeight;
      newPositions.add(Offset(x, y));
    }
    return newPositions;
  }

  List<Offset> generateRandomVelocities() {
    final List<Offset> newVelocities = [];

    for (int i = 0; i < numAirplanes; i++) {
      final double dx = random.nextDouble() * 2 - 1;
      final double dy = random.nextDouble() * 2 - 1;
      newVelocities.add(Offset(dx, dy));
    }
    return newVelocities;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < numAirplanes; i++)
          Positioned(
            top: positions[i].dy,
            left: positions[i].dx,
            child: Icon(
              Icons.airplanemode_active,
              color: Colors.blue,
              size: 24,
            ),
          ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  Color flashColor = Colors.black;
  Color usaColor = Colors.green; // Define color for USA

  @override
  void initState() {
    super.initState();

    // Initialize timer for flashing effect
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        flashColor = flashColor == Colors.red ? Colors.yellow : Colors.red;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6,
                  ),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (ResponsiveWidget.isLargeScreen(context) ||
              ResponsiveWidget.isMediumScreen(context))
            if (ResponsiveWidget.isCustomSize(context))
              OverviewCardsMediumScreen()
            else
              OverviewCardsLargeScreen()
          else
            OverviewCardsSmallScreen(),
          SizedBox(
            height: 400,
            child: Stack(
              children: [
                OSMMap(
                  height: 400,
                  markers: [
                    Marker(
                      point: LatLng(51.1657, 10.4515), // Germany
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: flashColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          'DE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Marker(
                      point: LatLng(39.8283, -98.5795), // USA
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: usaColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          'US',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Marker(
                      point: LatLng(-14.2350, -51.9253), // Brazil
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          'BR',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Marker(
                      point: LatLng(41.8719, 12.5674), // Italy
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          'IT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Marker(
                      point: LatLng(31.6295, -7.9811), // Morocco
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          'MA',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Marker(
                      point: LatLng(38.9637, 35.2433), // Turkey
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          'TR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedAirplane(context: context),
                Positioned.fill(
                  child: CustomPaint(
                    painter: LinePainter(),
                  ),
                ),
                Positioned(
                  // Add this Positioned widget for the location icon above Germany
                  top: 70, // Adjust the top position as needed
                  left: 185, // Adjust the left position as needed
                  child: Icon(
                    // Icon widget for the location icon
                    Icons.location_on,
                    color: Colors.red, // Choose the color for the location icon
                    size: 24, // Choose the size for the location icon
                  ),
                ),
                Positioned(
                  // Add this Positioned widget for the location icon above Germany
                  top: 37, // Adjust the top position as needed
                  left: 375, // Adjust the left position as needed
                  child: Icon(
                    // Icon widget for the location icon
                    Icons.location_on,
                    color: Colors.red, // Choose the color for the location icon
                    size: 24, // Choose the size for the location icon
                  ),
                ),
                Positioned(
                  // Add this Positioned widget for the location icon above Germany
                  bottom: 200, // Adjust the top position as needed
                  left: 340, // Adjust the left position as needed
                  child: Icon(
                    // Icon widget for the location icon
                    Icons.location_on,
                    color: Colors.red, // Choose the color for the location icon
                    size: 24, // Choose the size for the location icon
                  ),
                ),
                Positioned(
                  // Add this Positioned widget for the location icon above Germany
                  bottom: 100, // Adjust the top position as needed
                  left: 240, // Adjust the left position as needed
                  child: Icon(
                    // Icon widget for the location icon
                    Icons.location_on,
                    color: Colors.red, // Choose the color for the location icon
                    size: 24, // Choose the size for the location icon
                  ),
                ),
                Positioned(
                  // Add this Positioned widget for the location icon above Germany
                  bottom: 80, // Adjust the top position as needed
                  left: 640, // Adjust the left position as needed
                  child: Icon(
                    // Icon widget for the location icon
                    Icons.location_on,
                    color: Colors.red, // Choose the color for the location icon
                    size: 24, // Choose the size for the location icon
                  ),
                ),
                Positioned(
                  // Add this Positioned widget for the location icon above Germany
                  top: 100, // Adjust the top position as needed
                  left: 540, // Adjust the left position as needed
                  child: Icon(
                    // Icon widget for the location icon
                    Icons.location_on,
                    color: Colors.red, // Choose the color for the location icon
                    size: 24, // Choose the size for the location icon
                  ),
                ),
                Positioned(
                  // Add this Positioned widget for the location icon above Germany
                  top: 30, // Adjust the top position as needed
                  left: 440, // Adjust the left position as needed
                  child: Icon(
                    // Icon widget for the location icon
                    Icons.location_on,
                    color: Colors.red, // Choose the color for the location icon
                    size: 24, // Choose the size for the location icon
                  ),
                ),
                Positioned(
                  // Add this Positioned widget for the location icon above Germany
                  top: 50, // Adjust the top position as needed
                  left: 400, // Adjust the left position as needed
                  child: Icon(
                    // Icon widget for the location icon
                    Icons.location_on,
                    color: Colors.red, // Choose the color for the location icon
                    size: 24, // Choose the size for the location icon
                  ),
                ),
                Positioned(
                  // Add this Positioned widget for the location icon above Germany
                  top: 60, // Adjust the top position as needed
                  left: 480, // Adjust the left position as needed
                  child: Icon(
                    // Icon widget for the location icon
                    Icons.location_on,
                    color: Colors.red, // Choose the color for the location icon
                    size: 24, // Choose the size for the location icon
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter with ChangeNotifier {
  final int red;
  final int white;
  final int blue;
  double _offset = 0;

  LinePainter({this.red = 255, this.white = 0, this.blue = 0}) {
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 50), () {
      _offset += 10;
      if (_offset > 20) _offset = 0; // Reset offset when it reaches the end
      notifyListeners();
      _startAnimation();
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final germanyPosition =
        Offset(200, 90); // Example position for Germany (dE)
    final usaPosition = Offset(390, 65); // Example position for the USA

    final paint = Paint()
      ..color = Color.fromRGBO(red, white, blue, 1.0) // Custom RGB color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final linePath = ui.Path()
      ..moveTo(germanyPosition.dx, germanyPosition.dy)
      ..lineTo(usaPosition.dx, usaPosition.dy);

    final dashPath = ui.Path();
    dashPath.addPath(linePath, Offset.zero);
    canvas.drawPath(
      dashPath,
      paint
        ..color = Color.fromRGBO(
            red, white, blue, 0.3) // Adjust opacity for loading effect
        ..style = PaintingStyle.stroke,
    );

    final dashWidth = 15; // Adjust as needed for the length of each dash
    final dashSpace = 9; // Adjust as needed for the space between dashes
    final distance = 0;
    final metrics = dashPath.computeMetrics();
    for (final metric in metrics) {
      for (var distance = -_offset;
          distance < metric.length;
          distance += dashWidth + dashSpace) {
        final start = distance;
        final end = start + dashWidth;
        canvas.drawPath(
          metric.extractPath(start, end),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
