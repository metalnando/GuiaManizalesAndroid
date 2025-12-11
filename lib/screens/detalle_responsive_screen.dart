import 'package:flutter/material.dart';

class DetalleResponsiveScreen extends StatelessWidget {
  final Map<String, dynamic> lugar;
  
  const DetalleResponsiveScreen({
    super.key,
    required this.lugar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lugar['nombre']),
        backgroundColor: Colors.teal,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool usarFila = constraints.maxWidth >= 600;
          
          if (usarFila) {
            // Layout horizontal para tablets/pantallas anchas
            return Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    lugar['imagen'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported, size: 100),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: _buildContent(context), // Pasar context
                  ),
                ),
              ],
            );
          } else {
            // Layout vertical para móviles
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    lugar['imagen'],
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported, size: 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildContent(context), // Pasar context
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Ahora recibe el context como parámetro
  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lugar['nombre'],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          lugar['description'],
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            // Acción para abrir mapa (simulada)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Función de mapa - En desarrollo'),
              ),
            );
          },
          icon: const Icon(Icons.map),
          label: const Text('Ver en mapa'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}