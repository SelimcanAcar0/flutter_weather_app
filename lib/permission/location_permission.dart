import 'package:geolocator/geolocator.dart';

Future<Position> permLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error('Location Service Are Disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location Service Are Denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location Service Are Permanently Denied, We Cannot Permission',
    );
  }
  return Geolocator.getCurrentPosition();
}
