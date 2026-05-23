import 'package:dio/dio.dart';

import 'package:geolocator/geolocator.dart';

import 'api_service.dart';

class LocationService {
  final ApiService apiService = ApiService();

  Future<void> updateLocation(int workerId) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();

    await apiService.dio.post(
      "/locations/update",

      data: {
        "worker_id": workerId,

        "latitude": position.latitude,

        "longitude": position.longitude,
      },
    );
  }
}
