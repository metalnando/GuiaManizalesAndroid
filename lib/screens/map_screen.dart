import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<dynamic> lugares = [];
  final Set<Marker> _markers = {};
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarLugaresYCrearMarcadores();
  }

  Future<void> cargarLugaresYCrearMarcadores() async {
    final String raw = await rootBundle.loadString('assets/data/lugares.json');
    final List<dynamic> data = json.decode(raw);
    setState(() {
      lugares = data;
    });

    for (final lugar in lugares) {
      final LatLng pos = LatLng(lugar['lat'] * 1.0, lugar['lng'] * 1.0);
      final Marker marker = Marker(
        markerId: MarkerId(lugar['id'].toString()),
        position: pos,
        infoWindow: InfoWindow(
          title: lugar['nombre'],
          snippet: lugar['description'],
        ),
      );
      _markers.add(marker);
    }
    setState(() {
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LatLng centroInicial = lugares.isNotEmpty
        ? LatLng(lugares[0]['lat'] * 1.0, lugares[0]['lng'] * 1.0)
        : const LatLng(5.0703, -75.5137);

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Manizales'), backgroundColor: Colors.teal),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(target: centroInicial, zoom: 12),
              markers: _markers,
            ),
    );
  }
}