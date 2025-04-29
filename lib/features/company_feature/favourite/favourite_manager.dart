import 'package:hive/hive.dart';

class FavoriteManager {
  static final Box _favoritesBox = Hive.box('favorites');

  static List<Map<String, dynamic>> getFavorites() {
    return _favoritesBox.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static void addFavorite(Map<String, dynamic> product) {
    _favoritesBox.put(product['title'], product);
  }

  static void removeFavorite(String title) {
    _favoritesBox.delete(title);
  }

  static bool isFavorite(String title) {
    return _favoritesBox.containsKey(title);
  }
}
