import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:pcfsim_ui/constants/controllers.dart';
import 'package:pcfsim_ui/helpers/reponsiveness.dart';
import 'package:pcfsim_ui/pages/transport/widgets/transport_table.dart';
import 'package:pcfsim_ui/widgets/custom_text.dart';
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

class TransportPage extends StatelessWidget {
  const TransportPage({Key? key}) : super(key: key);

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
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 500,
            child: Stack(
              children: [
                const OSMMap(height: 500),
                AnimatedAirplane(context: context),
                Positioned(
                  top: 90,
                  left: 185,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 490,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 590,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 540,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 560,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 490,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 215,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 240,
                  left: 325,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 24,
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