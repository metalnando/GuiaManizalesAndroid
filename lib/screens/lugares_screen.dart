import 'package:flutter/material.dart';

class LugaresScreen extends StatefulWidget {
  @override
  _LugaresScreenState createState() => _LugaresScreenState();
}

class _LugaresScreenState extends State<LugaresScreen> {
  final List<Map<String, dynamic>> lugares = [
    {
      'nombre': 'Catedral Basílica de Manizales',
      'imagen': 'assets/images/catedral.jpg',
      'descripcion': 'Una joya arquitectónica que domina el centro de la ciudad.',
      'visitas': 0
    },
    {
      'nombre': 'Nevado del Ruiz',
      'imagen': 'assets/images/nevado.jpg',
      'descripcion': 'Imponente volcán y símbolo natural de la región.',
      'visitas': 0
    },
    {
      'nombre': 'Recinto del Pensamiento',
      'imagen': 'assets/images/recinto.jpg',
      'descripcion': 'Un espacio para la reflexión, la naturaleza y el saber.',
      'visitas': 0
    },
    {
      'nombre': 'Torre Chipre',
      'imagen': 'assets/images/chipre.jpg',
      'descripcion': 'Mirador con las mejores vistas del atardecer manizaleño.',
      'visitas': 0
    },
    {
      'nombre': 'Cable Aéreo',
      'imagen': 'assets/images/cable.jpg',
      'descripcion': 'Sistema de transporte único con vistas panorámicas.',
      'visitas': 0
    },
    {
      'nombre': 'Los Yarumos Ecoparque',
      'imagen': 'assets/images/yarumos.jpg',
      'descripcion': 'Reserva natural para el ecoturismo y la educación ambiental.',
      'visitas': 0
    },
  ];

  void marcarComoVisitado(int index) {
    setState(() {
      lugares[index]['visitas']++;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${lugares[index]['nombre']} marcado como visitado'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green.shade600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lugares Turísticos'),
        backgroundColor: Colors.green.shade600,
      ),
      body: ListView.builder(
        itemCount: lugares.length,
        itemBuilder: (context, index) {
          final lugar = lugares[index];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Placeholder para imagen (reemplazar con imágenes reales)
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.green.shade100,
                    child: Icon(Icons.photo, size: 60, color: Colors.green.shade400),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lugar['nombre'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          lugar['descripcion'],
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Visitas: ${lugar['visitas']}',
                              style: TextStyle(
                                color: Colors.green.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => marcarComoVisitado(index),
                              icon: Icon(Icons.explore),
                              label: Text('Marcar visitado'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}