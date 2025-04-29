// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:zamzam/features/location_feautre/model/location_model.dart';
// import 'package:zamzam/features/location_feautre/service/location_service.dart';

// class LocationPage extends StatefulWidget {
//   const LocationPage({Key? key}) : super(key: key);

//   @override
//   State<LocationPage> createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   Position? _currentPosition;
//   final LocationService _locationService = LocationService();

//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//   }

//   Future<void> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // تحقق من تفعيل خدمة تحديد المواقع
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return;
//     }

//     // تحقق من التصاريح
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return;
//     }

//     // احصل على الموقع الحالي
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     setState(() {
//       _currentPosition = position;
//     });
//   }

//   Future<void> _sendLocation() async {
//     if (_currentPosition != null) {
//       LocationModel locationModel = LocationModel(
//         name: "My Current Location",
//         address: "Detected by device",
//         city: "Unknown",
//         // latitude: _currentPosition!.latitude,
//         // longitude: _currentPosition!.longitude,
//         isDefault: true,
//       );

//       bool success = await _locationService.createLocation(locationModel);
//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Location sent successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to send location!')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Location'),
//       ),
//       body: _currentPosition == null
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Expanded(
//                   child: FlutterMap(
//                     options: MapOptions(
//                       initialCenter: LatLng(
//                         _currentPosition!.latitude,
//                         _currentPosition!.longitude,
//                       ),
//                       initialZoom: 15,
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate:
//                             "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                         subdomains: const ['a', 'b', 'c'],
//                       ),
//                       MarkerLayer(
//                         markers: [
//                           Marker(
//                             width: 80,
//                             height: 80,
//                             point: LatLng(
//                               _currentPosition!.latitude,
//                               _currentPosition!.longitude,
//                             ),
//                             child: const Icon(
//                               Icons.location_pin,
//                               color: Colors.red,
//                               size: 40,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton.icon(
//                     onPressed: _sendLocation,
//                     icon: const Icon(Icons.send),
//                     label: const Text("Send Location"),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 16.0, horizontal: 24.0),
//                       textStyle: const TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
