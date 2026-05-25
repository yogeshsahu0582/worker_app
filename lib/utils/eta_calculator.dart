class ETACalculator {
  static String calculateETA(double distanceKm) {
    double averageSpeed = 35;

    double hours = distanceKm / averageSpeed;

    int minutes = (hours * 60).round();

    return "$minutes mins";
  }
}
