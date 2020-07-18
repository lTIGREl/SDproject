import 'package:location/location.dart';

Future<List<String>> obtainLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    location.requestService().whenComplete(() async {
      _serviceEnabled = await location.serviceEnabled();
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        location.requestPermission().whenComplete(() async {
          _permissionGranted = await location.hasPermission();
        });
      }
    });
  }
  _locationData = await location.getLocation();
  return [
    _locationData.latitude.toString(),
    _locationData.longitude.toString()
  ];
}
