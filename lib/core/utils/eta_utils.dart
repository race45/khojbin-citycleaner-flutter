class EtaUtils {
  // speeds in km/h
  static const double _walkSpeed = 5;
  static const double _bikeSpeed = 15;
  static const double _carSpeed = 40;

  static String walkingEta(double distanceKm) {
    return _formatTime(distanceKm / _walkSpeed);
  }

  static String cyclingEta(double distanceKm) {
    return _formatTime(distanceKm / _bikeSpeed);
  }

  static String drivingEta(double distanceKm) {
    return _formatTime(distanceKm / _carSpeed);
  }

  static String _formatTime(double hours) {
    final totalMinutes = (hours * 60).round();

    if (totalMinutes < 60) {
      return "$totalMinutes min";
    }

    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    return "${h}h ${m}m";
  }
}
