// favoritos_service.dart
// Servicio simple para guardar y recuperar favoritos usando shared_preferences.
//
// Qué: encapsula operaciones de lectura/escritura en shared_preferences.
// Por qué: separar la lógica de persistencia de la UI promueve claridad y reuso.
// Para qué: permitir guardar una lista de IDs de lugares que el usuario marcó como favorito.
import 'dart:convert'; // Para convertir lista <-> string (JSON).
import 'package:shared_preferences/shared_preferences.dart';
class FavoritosService {
 static const String _claveFavoritos = 'favoritos_manizales';
 // Guarda la lista de ids (Strings) como JSON en shared_preferences.29
 static Future<void> guardarFavoritos(List<String> ids) async
  {
     final prefs = await SharedPreferences.getInstance(); // Obtener instancia.
     final String jsonStr = jsonEncode(ids); // Convertir a texto.
     await prefs.setString(_claveFavoritos, jsonStr); // Guardar como String.
     }
 // Recupera la lista; si no existe, retorna lista vacía.
 static Future<List<String>> obtenerFavoritos() async 
 {
  final prefs = await SharedPreferences.getInstance();
  final String? jsonStr = prefs.getString(_claveFavoritos);
  if (jsonStr == null || jsonStr.isEmpty) return <String>[];
 try {
  final List<dynamic> decoded = jsonDecode(jsonStr);
  return decoded.map((e) => e.toString()).toList();
 } catch (e) {
 // Si hay error en el parseo, devolvemos lista vacía (robustez).
 return <String>[];
 }
 }
 // Limpia todos los favoritos (útil para pruebas).
 static Future<void> borrarFavoritos() async {
 final prefs = await SharedPreferences.getInstance();
 await prefs.remove(_claveFavoritos);
 }
}