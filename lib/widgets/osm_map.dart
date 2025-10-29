import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OSMMap extends StatelessWidget {
  final LatLng center;
  final double zoom;
  final List<Marker> markers;
  final double? height;

  const OSMMap({
    super.key,
    this.center = const LatLng(20.0, 0.0), // World view centered
    this.zoom = 2.0, // World zoom level
    this.markers = const [],
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final map = FlutterMap(
      options: MapOptions(
        initialCenter: center,
        initialZoom: zoom,
        minZoom: 1.0,
        maxZoom: 18.0,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'pcfsim_ui',
          tileProvider: NetworkTileProvider(),
        ),
        if (markers.isNotEmpty) MarkerLayer(markers: markers),
      ],
    );

    if (height != null) {
      return SizedBox(
        height: height, 
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8), 
          child: map
        )
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8), 
      child: map
    );
  }
}


