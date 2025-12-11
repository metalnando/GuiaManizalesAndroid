import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../services/favoritos_service.dart'; 

class LugaresFavoritosScreen extends StatefulWidget {
  const LugaresFavoritosScreen({super.key});

  @override
  State<LugaresFavoritosScreen> createState() => _LugaresFavoritosScreenState();
}

class _LugaresFavoritosScreenState extends State<LugaresFavoritosScreen> {
  List<dynamic> lugares = [];
  List<bool> favoritos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarLugaresYPreferencias();
  }

  Future<void> cargarLugaresYPreferencias() async {
    final String raw = await rootBundle.loadString('assets/data/lugares.json');
    final List<dynamic> data = json.decode(raw);
    
    // Obtener favoritos PERSISTENTES
    final List<String> favoritosPersistidos = await FavoritosService.obtenerFavoritos();

    setState(() {
      lugares = data;
      // Inicializar basado en lo guardado permanentemente
      favoritos = List<bool>.generate(
        lugares.length,
        (i) => favoritosPersistidos.contains(lugares[i]['id'].toString()),
      );
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lugares — Favoritos'),
        backgroundColor: Colors.teal,
        actions: [
          // Botón para limpiar favoritos (opcional, para pruebas)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await FavoritosService.borrarFavoritos();
              setState(() {
                favoritos = List<bool>.filled(lugares.length, false);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favoritos eliminados')),
              );
            },
          ),
        ],
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: lugares.length,
              itemBuilder: (context, index) {
                final lugar = lugares[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        lugar['imagen'],
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                    title: Text(lugar['nombre']),
                    subtitle: Text(
                      lugar['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        favoritos[index]
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favoritos[index] ? Colors.red : Colors.grey,
                      ),
                      onPressed: () async {
                        // Actualizar estado local
                        setState(() {
                          favoritos[index] = !favoritos[index];
                        });

                        // Guardar PERMANENTEMENTE
                        final List<String> idsFavoritos = [];
                        for (int i = 0; i < lugares.length; i++) {
                          if (favoritos[i]) {
                            idsFavoritos.add(lugares[i]['id'].toString());
                          }
                        }
                        await FavoritosService.guardarFavoritos(idsFavoritos);

                        // Feedback al usuario
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              favoritos[index]
                                  ? 'Añadido a favoritos'
                                  : 'Eliminado de favoritos',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(lugar['nombre']),
                            content: Text(lugar['description']),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cerrar'),
                              ),
                            ],
                          ),
                        );
                      },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          final int totalFavs = favoritos.where((f) => f).length;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tienes $totalFavs lugares favoritos'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }
}