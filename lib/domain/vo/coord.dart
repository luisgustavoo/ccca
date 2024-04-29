class Coord {
  Coord(double lat, double long)
      : _lat = lat,
        _long = long {
    if (_lat < -90 || _lat > 90) {
      throw Exception('Invalid latitude');
    }
    if (_long < -180 || _long > 180) {
      throw Exception('Invalid longitude');
    }

    _lat = lat;
    _long = long;
  }

  late final double _lat;
  late final double _long;

  double getLat() {
    return _lat;
  }

  double getLong() {
    return _long;
  }
}
