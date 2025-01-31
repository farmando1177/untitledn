import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LatLng _currentLocation = const LatLng(21.3891, 39.8579); // مكة الموقع الافتراضي
  MapType _currentMapType = MapType.normal; // نوع الخريطة الافتراضي
  final CollectionReference binsCollection = FirebaseFirestore.instance.collection('waste_bins');

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadBinsFromFirebase();
  }

  /// 📌 **الحصول على الموقع الحالي**
  Future<void> _getCurrentLocation() async {
    Location location = Location();
    try {
      LocationData locationData = await location.getLocation();
      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
      });
      _moveCamera(_currentLocation);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  /// 📌 **تحميل الحاويات من Firestore عند تشغيل التطبيق**
  void _loadBinsFromFirebase() {
    binsCollection.snapshots().listen((snapshot) {
      setState(() {
        _markers.clear();
        for (var doc in snapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          _markers.add(
            Marker(
              markerId: MarkerId(doc.id),
              position: LatLng(data['lat'], data['lng']),
              draggable: true, // ✅ يمكن سحبه
              onDragEnd: (newPosition) {
                _updateBinLocation(doc.id, newPosition);
              },
              onTap: () {
                _deleteBin(doc.id);
              },
              infoWindow: InfoWindow(title: 'Waste Bin', snippet: 'Status: ${data['status']}'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            ),
          );
        }
      });
    });
  }

  /// 📌 **تحديث موقع الحاوية في Firebase عند سحبها**
  Future<void> _updateBinLocation(String id, LatLng newPosition) async {
    await binsCollection.doc(id).update({'lat': newPosition.latitude, 'lng': newPosition.longitude});
  }

  /// 📌 **حذف الحاوية عند الضغط عليها**
  Future<void> _deleteBin(String id) async {
    await binsCollection.doc(id).delete();
  }

  /// 📌 **حفظ الحاوية إلى Firestore**
  Future<void> _saveBinToFirebase(LatLng position) async {
    await binsCollection.add({'lat': position.latitude, 'lng': position.longitude, 'status': 'New'});
  }

  /// 📌 **إضافة ماركر عند النقر مع الحفظ في Firebase**
  void _onMapTapped(LatLng tappedPoint) async {
    await _saveBinToFirebase(tappedPoint);
  }

  /// 📌 **إضافة خط بين الحاويات**
  void _addPolyline() {
    if (_markers.length < 2) return; // تأكد من وجود نقطتين على الأقل
    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: _markers.map((m) => m.position).toList(),
          color: Colors.blue,
          width: 4,
        ),
      );
    });
  }

  /// 📌 **تغيير نوع الخريطة بين عادي وقمر صناعي**
  void _toggleMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  /// 📌 **تحريك الكاميرا إلى موقع معين**
  void _moveCamera(LatLng position) {
    mapController.animateCamera(CameraUpdate.newLatLng(position));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: _toggleMapType, // ✅ تغيير نوع الخريطة
          ),
          IconButton(
            icon: const Icon(Icons.add_road),
            onPressed: _addPolyline, // ✅ رسم المسار بين الحاويات
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () => mapController.animateCamera(CameraUpdate.zoomIn()),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () => mapController.animateCamera(CameraUpdate.zoomOut()),
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 14.0),
        markers: _markers,
        polylines: _polylines,
        mapType: _currentMapType,
        myLocationEnabled: true, // ✅ عرض الموقع الحالي
        zoomControlsEnabled: false, // ❌ إلغاء الأزرار الافتراضية لأننا استخدمنا أزرار مخصصة
        onTap: _onMapTapped, // ✅ إضافة ماركر وحفظه في Firebase
      ),
    );
  }
}