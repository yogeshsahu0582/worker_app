import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveRoutePolyline extends StatelessWidget {
  final Set<Polyline> polylines;

  final Set<Marker> markers;

  final CameraPosition initialPosition;

  const LiveRoutePolyline({
    super.key,

    required this.polylines,

    required this.markers,

    required this.initialPosition,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialPosition,

      polylines: polylines,

      markers: markers,

      myLocationEnabled: true,

      zoomControlsEnabled: false,
    );
  }
}
