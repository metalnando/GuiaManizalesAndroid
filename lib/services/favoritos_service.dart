import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosService {
  static const String _claveFavoritos = 'favoritos_manizales';

  static Future<void> guardarFavoritos(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonStr = jsonEncode(ids);
    await prefs.setString(_claveFavoritos, jsonStr);
  }

  static Future<List<String>> obtenerFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_claveFavoritos);
    if (jsonStr == null || jsonStr.isEmpty) return <String>[];
    try {
      final List<dynamic> decoded = jsonDecode(jsonStr);
      return decoded.map((e) => e.toString()).toList();
    } catch (e) {
      return <String>[];
    }
  }

  static Future<void> borrarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_claveFavoritos);
  }
}