import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Meal> _favorites = [];

  List<Meal> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesString = prefs.getString('favorites');

    if (favoritesString != null) {
      final List<dynamic> decoded = jsonDecode(favoritesString);
      _favorites = decoded.map((item) => Meal.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(_favorites.map((meal) => meal.toJson()).toList());
    await prefs.setString('favorites', encoded);
  }

  void toggleFavorite(Meal meal) {
    final existingIndex = _favorites.indexWhere((m) => m.id == meal.id);

    if (existingIndex >= 0) {
      _favorites.removeAt(existingIndex);
    } else {
      _favorites.add(meal);
    }

    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Meal meal) {
    return _favorites.any((m) => m.id == meal.id);
  }

  void clearFavorites() {
    _favorites.clear();
    _saveFavorites();
    notifyListeners();
  }
}