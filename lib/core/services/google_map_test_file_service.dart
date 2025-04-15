import 'dart:io';

class GoogleMapTestFileService {
  static const String _googleMapTestContent = '''

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapTest extends StatefulWidget {
  const GoogleMapTest({Key? key}) : super(key: key);

  @override
  _GoogleMapTestState createState() => _GoogleMapTestState();
}

class _GoogleMapTestState extends State<GoogleMapTest> {
  late GoogleMapController _mapController;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 12,
  );

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map Test'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialPosition,
      ),
    );
  }
}
''';

  static Future<void> copyGoogleMapTestFile(String projectPath) async {
    final libDir = Directory('\$projectPath/lib');
    if (!await libDir.exists()) {
      await libDir.create(recursive: true);
    }

    final destinationPath = '$projectPath/lib/google_map_test.dart';
    final demoFile = File(destinationPath);

    await demoFile.writeAsString(_googleMapTestContent);

    print('google_map_test.dart successfully copied to $projectPath/lib/');
  }
}
