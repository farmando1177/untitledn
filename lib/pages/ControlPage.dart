import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late GoogleMapController mapController;

  // النقاط التي تمثل الحاويات والطائرات
  final Set<Marker> _markers = {};

  // إعدادات الخريطة
  static const LatLng _center =
  LatLng(37.7749, -122.4194); // تحديد موقع البداية (مثل سان فرانسيسكو)

  @override
  void initState() {
    super.initState();

    // إضافة نقاط الحاويات والطائرات
    _markers.add(
      const Marker(
        markerId: MarkerId('waste_bin_1'),
        position: LatLng(37.7749, -122.4194), // موقع الحاوية
        infoWindow: InfoWindow(title: 'Waste Bin 1', snippet: 'Full'),
      ),
    );
    _markers.add(
      const Marker(
        markerId: MarkerId('drone_1'),
        position: LatLng(37.7750, -122.4200), // موقع الطائرة
        infoWindow: InfoWindow(title: 'Drone 1', snippet: 'In transit'),
      ),
    );
    _markers.add(
      const Marker(
        markerId: MarkerId('drone_2'),
        position: LatLng(37.7751, -122.4195), // موقع طائرة أخرى
        infoWindow: InfoWindow(title: 'Drone 2', snippet: 'Returning'),
      ),
    );
  }

  // دالة لتحديد الخريطة
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Control Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // النص في أعلى الصفحة
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Monitor waste container levels',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ),

          // عرض الخريطة أسفل النص
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              markers: _markers, // إضافة النقاط
            ),
          ),
        ],
      ),
    );
  }
}